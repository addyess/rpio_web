<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm">
    <link rel="stylesheet" href="/css/slider.css">
    <title>GPIO</title>
</head>
<body>
    <script src="/js/jquery-3.3.1.min.js"></script>
    <script src="/js/popper.min.js"></script>
    <script src="/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"></script>

    <div class="modal fade" id="completedModal" tabindex="-1" role="dialog" aria-labelledby="completedLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="completedLabel"></h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div id="completedBody" class="modal-body">
            ...
          </div>
        </div>
      </div>
    </div>

    <div class="container">
        <!--Navigation bar-->
        <div id="nav-placeholder"></div>
        <script>$(function(){ $("#nav-placeholder").load("/navbar.html");});</script>

        <div class="row">
            <div class="col-sm"><h1 class="">GPIO</h1></div>
        </div>
        <div>
            <table class="table table-dark">
              <thead>
                <tr>
                  <th scope="col">Pin</th>
                  <th scope="col">Mode</th>
                  <th scope="col">Label</th>
                  <th scope="col">Direction</th>
                  <th scope="col">State</th>
                </tr>
              </thead>
              <tbody>
                % for item in gpio:
                <tr>
                  <td scope="col">{{item.ident}}</td>
                  <td scope="col">
                  <div class="dropdown">
                      <button class="btn btn-secondary dropdown-toggle" type="button" width=300
                              data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        {{item.mode}}
                      </button>
                      <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                        % for m in item.supported_modes:
                          <a class="dropdown-item href="#">{{m}}</a>
                        % end
                      </div>
                    </div>
                  </td>
                  <td scope="col">
                    <input id="{{item.ident}}" type="text" class="gpio-label"
                           value="{{item.label}}" aria-label="GPIO Label"/>
                  </td>
                  <td scope="col">
                    I<label class="switch">
                      <input type="checkbox" disabled {{"" if item.is_input else "checked"}}>
                      <span class="slider round"></span>
                    </label>O
                  </td>
                  <td scope="col">
                    <h3>
                      <span class="badge {{'badge-primary' if item.state == 'up' else 'badge-secondary'}}">{{item.state}}</span>
                    </h3>
                  </td>
                </tr>
                % end
              </tbody>
            </table>
            <script><!--
              $(function(){
                $(".gpio-label").change(function(){
                  var id = $(this).attr('id');
                  var label = $(this).val()
                  console.log("New Value for GPIO " + id + " is " + label);
                  $.ajax('/gpio', {
                    data : JSON.stringify({id:id, label:label}),
                    contentType: 'application/json',
                    type: 'POST'
                  }).done(function(){
                        $('#completedLabel').text("Updated Successfully");
                        $('#completedBody').text("")
                        $("#completedModal").modal('show');
                    })
                    .fail(function(_, errorStatus){
                        $('#completedLabel').text("Failed to update");
                        $('#completedBody').text(errorStatus)
                        $("#completedModal").modal('show');
                    })
                });
              });
            --></script>
        </div>
    </div>

</body>
</html>