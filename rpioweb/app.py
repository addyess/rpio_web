from bottle import *
import logging
import os
from hardware import Hardware

ROOT = os.path.abspath(os.path.dirname(__file__))
VIEWS = os.path.join(ROOT, 'views')
STATIC = os.path.join(ROOT, 'static')
TEMPLATE_PATH.insert(0, VIEWS)


def run_forever(hardware):
    app = Bottle()

    @app.get('/conditions.html')
    def _():
        class NewFormOptions:
            triggers = ['Active', 'Clear']
            pins = hardware.get_gpio()
            outcome = ['Assert', 'Email', 'Text', 'Log']
        return template('conditions', conditions=hardware.conditions, new_form=NewFormOptions())

    @app.get('/events.html')
    def _():
        return template('events', events=hardware.get_events())

    @app.get('/gpio.html')
    def _():
        return template('gpio', gpio=hardware.get_gpio())

    @app.post('/gpio')
    def _():
        try:
            pin_id, label = request.json['id'], request.json['label']
        except IndexError as e:
            return HTTPError(400, "Key Missing: {}".format(e))
        try:
            pin_id = int(pin_id)
        except ValueError as v:
            return HTTPError(400, "Invalid GPIO Id: {}".format(v))
        gpio = list(filter(lambda p: p.ident == pin_id, hardware.get_gpio()))
        if not gpio:
            return HTTPError(404, "GPIO Pin {} not found".format(pin_id))
        gpio[0].label = label

    @app.get('/')
    @app.get('/<path:path>')
    def _(path='index.html'):
        return static_file(path, STATIC)

    app.run(port=8080, reloader=True, debug=True)


if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    hardware = Hardware()
    run_forever(hardware)
