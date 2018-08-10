<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm">
    <title>Conditions</title>
</head>
<body>
    <script src="/js/jquery-3.3.1.min.js"></script>
    <script src="/js/popper.min.js"></script>
    <script src="/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"></script>

    <div class="container">
        <!--Navigation bar-->
        <div id="nav-placeholder"></div>
        <script>$(function(){ $("#nav-placeholder").load("/navbar.html");});</script>

        <div class="row">
            <div class="col-sm"><h1 class=""> Conditions </h1></div>
            <table class="table table-dark">
              <thead>
                <tr>
                  <th scope="col">Order</th>
                  <th scope="col">Trigger</th>
                  <th scope="col">Pin Label</th>
                  <th scope="col">Outcome</th>
                  <th scope="col">Description</th>
                </tr>
              </thead>
              <tbody>
                % for idx, item in enumerate(conditions):
                <tr>
                  <th scope="col">{{idx+1}}</th>
                  <td scope="col">{{item.trigger}}</td>
                  <td scope="col">{{item.label}}</td>
                  <td scope="col">{{item.outcome}}</td>
                  <td scope="col">{{item.description}}</td>
                </tr>
                % end
              </tbody>
              <tfoot>
                <tr>
                  <form>
                    <th scope="col">{{len(conditions) + 1}}</th>
                    <th scope="col">
                     <select class="custom-select">
                     % for t in new_form.triggers:
                       <option class="dropdown-item" value="{{t.lower()}}">{{t}}</option>
                     % end
                     </select>
                    </th>
                    <th scope="col">
                     <select class="custom-select">
                     % for p in new_form.pins:
                       <option class="dropdown-item" value="{{p.ident}}">{{p.label}}</option>
                     % end
                     </select>
                    </th>
                    <th scope="col">
                     <select class="custom-select">
                     % for o in new_form.outcome:
                       <option class="dropdown-item" value="{{o.lower()}}">{{o}}</option>
                     % end
                     </select>
                    </th>
                    <th scope="col"></th>
                  </form>
                </tr>
              </tfoot>
            </table>
        </div>
    </div>

</body>
</html>