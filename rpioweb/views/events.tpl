<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm">
    <title>Events</title>
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
            <div class="col-sm"><h1 class=""> Events </h1></div>
            <table class="table table-dark">
              <thead>
                <tr>
                  <th scope="col">#</th>
                  <th scope="col">Date and time</th>
                  <th scope="col">GPIO (Label)</th>
                  <th scope="col">Description</th>
                </tr>
              </thead>
              <tbody>
                % for idx, item in enumerate(events):
                <tr>
                  <th scope="col">{{idx+1}}</th>
                  <td scope="col">{{item.date}}</td>
                  <td scope="col">{{item.label}}</td>
                  <td scope="col">{{item.description}}</td>
                </tr>
                % end
              </tbody>
            </table>
        </div>
    </div>

</body>
</html>