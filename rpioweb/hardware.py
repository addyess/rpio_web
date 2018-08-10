from datetime import datetime
import timeago


PIN_MAP = [
    (1, "3.3V DC", ["3.3V DC"]),
    (2, "5V DC", ["5V DC"]),
    (3, "GPIO-02", ["GPIO-02", "SDA1", "I2C"]),
    (4, "5V DC", ["5V DC"]),
    (5, "GPIO-03", ["GPIO-03", "SCL1", "I2C"]),
    (6, "Ground", ["Ground"]),
    (7, "GPIO-04", ["5V DC"]),
]


class _HwGPIO(object):
    def __init__(self, identity, label, supported_modes=list()):
        self.ident = identity
        self.input = False
        self._mode = supported_modes[0]
        self.supported_modes = supported_modes
        self._label = label

    @property
    def mode(self):
        return self._mode

    @mode.setter
    def mode(self, value):
        if value in self.supported_modes:
            self._mode = value
        else:
            raise NotImplementedError("Mode {} not supported on this pin".format(value))

    @property
    def is_input(self):
        return self.input

    @property
    def label(self):
        return self._label

    @label.setter
    def label(self, value):
        self._label = value

    @property
    def state(self):
        return "down"


class _HwEvent(object):
    def __init__(self, gpio: _HwGPIO, description):
        self.created_dt = datetime.now()
        self.pin = gpio
        self.description = description

    @property
    def date(self):
        return timeago.format(self.created_dt)

    @property
    def label(self):
        return self.pin.label


class Hardware(object):
    def __init__(self):
        self.gpio = [_HwGPIO(*t) for t in PIN_MAP]
        self.events = [_HwEvent(self.gpio[0], "Transitioned Up")]
        self.conditions = []

    def get_events(self):
        return self.events

    def get_gpio(self):
        return self.gpio
