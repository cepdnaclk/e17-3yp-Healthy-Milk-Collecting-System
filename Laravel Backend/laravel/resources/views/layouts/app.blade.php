
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>MilkTab | Dashboard</title>
  
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="{{asset('plugins/fontawesome-free/css/all.min.css')}}">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Tempusdominus Bootstrap 4 -->
  <link rel="stylesheet" href="{{asset('plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css')}}">
  <!-- iCheck -->
  <link rel="stylesheet" href="{{asset('plugins/icheck-bootstrap/icheck-bootstrap.min.css')}}">
  <!-- JQVMap -->
  <link rel="stylesheet" href="{{asset('plugins/jqvmap/jqvmap.min.css')}}">
  <!-- Theme style -->
  <link rel="stylesheet" href="{{asset('dist/css/adminlte.min.css')}}">
  <!-- overlayScrollbars -->
  <link rel="stylesheet" href="{{asset('plugins/overlayScrollbars/css/OverlayScrollbars.min.css')}}">
  <!-- Daterange picker -->
  <link rel="stylesheet" href="{{asset('plugins/daterangepicker/daterangepicker.css')}}">
  <!-- summernote -->
  <link rel="stylesheet" href="{{asset('plugins/summernote/summernote-bs4.min.css')}}">

    <!-- Ion Slider -->
  <link rel="stylesheet" href="{{asset('plugins/ion-rangeslider/css/ion.rangeSlider.min.css')}}">
  <!-- bootstrap slider -->
  <link rel="stylesheet" href="{{asset('plugins/bootstrap-slider/css/bootstrap-slider.min.css')}}">
  <!-- Theme style -->
  <link rel="stylesheet" href="{{asset('dist/css/adminlte.min.css')}}">
 
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">
  <!-- Navbar -->
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li>
      <!-- <li class="nav-item d-none d-sm-inline-block">
        <a href="#" class="nav-link">Home</a>
      </li>
      <li class="nav-item d-none d-sm-inline-block">
        <a href="#" class="nav-link">Contact</a>
      </li> -->
    </ul>

    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto">
      <li class="nav-item">
        <a class="nav-link"  href="{{route('admin.logout')}}" role="button">
          <i class="fas fa-sign-out-alt"></i>
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" data-widget="fullscreen" href="#" role="button">
          <i class="fas fa-expand-arrows-alt"></i>
        </a>
      </li>
      
    </ul>
  </nav>
<aside class="main-sidebar sidebar-dark-primary elevation-4">


    <!-- Brand Logo -->
    <a href="" class="brand-link">
      <!-- <img src="{{ asset('dist/img/AdminLTElogo.png')}}" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: 1"> -->
      <span class="brand-text font-weight-light pl-2">MilkTab Dashboard</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
          <img src="{{ asset('dist/img/team/profile.png')}}" class="img" alt="User Image">
        </div>
        <div class="info">
          <a href="{{ route('admin.edit_self')}}" class="d-block">
            <?php $username = session()->get('user');?>
            {{$username}}
          </a>
        </div>
      </div>

      <!-- SidebarSearch Form -->
      <!--<div class="form-inline">
        <div class="input-group" data-widget="sidebar-search">
          <input class="form-control form-control-sidebar" type="search" placeholder="Search" aria-label="Search">
          <div class="input-group-append">
            <button class="btn btn-sidebar">
              <i class="fas fa-search fa-fw"></i>
            </button>
          </div>
        </div>
      </div> -->

      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
          <li class="nav-item">
          @if (request()->is('main'))
            <a href="{{ route('admin.dashboard')}}"  class="nav-link nav-items active">
           
          @else
          <a href="{{ route('admin.dashboard')}}"  class="nav-link nav-items" >  
          @endif 
          <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                Dashboard
                
              </p>
            </a>
            
          </li>
          <li class="nav-item">
          @if (request()->is('main/links'))
            <a href="{{ route('admin.dashboard.links')}} " class="nav-link nav-items active">
          @else 
            <a href="{{ route('admin.dashboard.links')}} " class="nav-link nav-items">  
          @endif  
            <i class="nav-icon fas fa-th"></i>
              <p>
                Links
                <!--<span class="right badge badge-danger">New</span>-->
              </p>
            </a>
          </li>
          @if (request()->is('main/collectors') || request()->is('main/farmers') || request()->is('main/admins') || request()->is('main/devices'))
          <li class="nav-item menu-open">
          @else   
          <li class="nav-item">
          @endif 
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-copy"></i>
              <p>
                Entities
                <i class="fas fa-angle-left right"></i>
                <span class="badge badge-info right">4</span>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
              @if (request()->is('main/collectors'))
                <a href="{{ route('admin.dashboard.collectors')}} " class="nav-link nav-items active">
              @else 
                <a href="{{ route('admin.dashboard.collectors')}} " class="nav-link nav-items ">
              @endif  
                <i class="far fa-circle nav-icon"></i>
                  <p>Collectors</p>
                </a>
              </li>
              <li class="nav-item">
              @if (request()->is('main/farmers'))
                <a href="{{ route('admin.dashboard.farmers')}} " class="nav-link nav-items active">
              @else 
                <a href="{{ route('admin.dashboard.farmers')}} " class="nav-link nav-items">  
              @endif 
                <i class="far fa-circle nav-icon"></i>
                  <p>Farmers</p>
                </a>
              </li>
              <li class="nav-item">
              @if (request()->is('main/admins'))
                <a href="{{ route('admin.dashboard.admins')}} " class="nav-link nav-items" >
              @else
                <a href="{{ route('admin.dashboard.admins')}} " class="nav-link nav-items" > 
              @endif  
              <i class="far fa-circle nav-icon"></i>
                  <p>Admins</p>
                </a>
              </li>
              <li class="nav-item">
              @if (request()->is('main/devices'))
                <a href="{{ route('admin.dashboard.devices')}} " class="nav-link nav-items active">
              @else
              <a href="{{ route('admin.dashboard.devices')}} " class="nav-link nav-items">
              @endif 
                  <i class="far fa-circle nav-icon"></i>
                  <p>Devices</p>
                </a>
              </li>
            </ul>
          </li>
          @if (request()->is('main/daily_records') || request()->is('main/sub_records'))
          <li class="nav-item menu-open">
          @else
          <li class="nav-item">
          @endif
            <a href="#" class="nav-link nav-items" >
              <i class="fas fa-sticky-note nav-icon"></i>
              <p>
                Records
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
              @if (request()->is('main/daily_records'))
                <a href="{{ route('admin.dashboard.daily_records')}} " class="nav-link" class="nav-link nav-items active">
              @else
              <a href="{{ route('admin.dashboard.daily_records')}} " class="nav-link" class="nav-link nav-items">
              @endif
                <i class="far fa-circle nav-icon"></i>
                  <p>Daily Records</p>
                </a>
              </li>
              <li class="nav-item">
              @if (request()->is('main/sub_records'))
              <a href="{{ route('admin.dashboard.sub_records')}} " class="nav-link active">
              @else
              <a href="{{ route('admin.dashboard.sub_records')}} " class="nav-link">
              @endif
                  <i class="far fa-circle nav-icon"></i>
                  <p>Sub Records</p>
                </a>
              </li>
            </ul>
          </li>
          @if (request()->is('main/pricerate') ||request()->is('main/get-volume-filter')|| request()->is('main/price-all')||request()->is('main/quality-chart-filter'))
          <li class="nav-item menu-open">
          @else
          <li class="nav-item">
          @endif
            <a href="#" class="nav-link nav-items" >
              <i class="nav-icon fas fa-chart-pie"></i>
              <p>
                Charts
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
              @if (request()->is('main/pricerate'))
                <a href="{{ route('admin.get-price-filter') }}" class="nav-link active">
              @else  
              <a href="{{ route('admin.get-price-filter') }}" class="nav-link">
              @endif
              <i class="far fa-circle nav-icon"></i>
                  <p>PriceRate</p>
                </a>
              </li>
              <li class="nav-item">
              @if (request()->is('main/price-all'))
                <a href="{{ route('admin.get-price-bar') }}" class="nav-link active">
                @else  
                <a href="{{ route('admin.get-price-bar') }}" class="nav-link">
                @endif
                  <i class="far fa-circle nav-icon"></i>
                  <p>Price All</p>
                </a>
              </li>
              <li class="nav-item">
              @if (request()->is('main/quality-chart-filter'))
                <a href="{{ route('admin.get-chart-filter') }}" class="nav-link active">
                @else  
                <a href="{{ route('admin.get-chart-filter') }}" class="nav-link">
                @endif
                  <i class="far fa-circle nav-icon"></i>
                  <p>Quality Variation</p>
                </a>
              </li>
              <li class="nav-item">
              @if (request()->is('main/get-volume-filter'))
                <a href="{{ route('admin.get-volume-filter') }}" class="nav-link active">
                @else 
                <a href="{{ route('admin.get-volume-filter') }}" class="nav-link">
                @endif
                  <i class="far fa-circle nav-icon"></i>
                  <p>Volume Variation</p>
                </a>
              </li>
            </ul>
          </li>
          
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <img src="{{ asset('dist/img/backgrounds/bg3.jpg')}}" style="position:absolute; width:100%">
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Dashboard</h1>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              
              <li class="breadcrumb-item active">Dashboard v1</li>
            </ol>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <section class="content">
      
        <!-- Small boxes (Stat box) -->
        <!-- <iframe src="/dashboard/main" name="ifram_main" width="95%" style="position: absolute; height: 100%; border: none;"></iframe> -->
      <!-- /.container-fluid -->
        <!-- /.row (main row) -->
        @yield('content')
     
     
    </section>
    <!-- /.content -->
  </div>
  
<!-- jQuery -->
<script src="{{ asset('plugins/jquery/jquery.min.js')}}"></script>
<!-- jQuery UI 1.11.4 -->
<script src="{{ asset('plugins/jquery-ui/jquery-ui.min.js')}}"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->

<!-- Bootstrap 4 -->
<script src="{{ asset('plugins/bootstrap/js/bootstrap.bundle.min.js')}}"></script>
<!-- ChartJS -->
<script src="{{ asset('plugins/chart.js/Chart.min.js')}}"></script>
<!-- Sparkline -->
<script src="{{ asset('plugins/sparklines/sparkline.js')}}"></script>
<!-- JQVMap -->
<script src="{{ asset('plugins/jqvmap/jquery.vmap.min.js')}}"></script>
<script src="{{ asset('plugins/jqvmap/maps/jquery.vmap.usa.js')}}"></script>
<!-- jQuery Knob Chart -->
<script src="{{ asset('plugins/jquery-knob/jquery.knob.min.js')}}"></script>
<!-- daterangepicker -->
<script src="{{asset('plugins/moment/moment.min.js')}}"></script>
<script src="{{ asset('plugins/daterangepicker/daterangepicker.js')}}"></script>
<!-- Tempusdominus Bootstrap 4 -->
<script src="{{ asset('plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js')}}"></script>
<!-- Summernote -->
<script src="{{ asset('plugins/summernote/summernote-bs4.min.js')}}"></script>
<!-- overlayScrollbars -->
<script src="{{ asset('plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js')}}"></script>
<!-- AdminLTE App -->
<script src="{{ asset('dist/js/adminlte.js')}}"></script>
<!-- AdminLTE for demo purposes -->
<script src="{{ asset('dist/js/demo.js')}}"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="{{ asset('dist/js/pages/dashboard.js')}}"></script>



<script type="text/javascript">
</script>
</body>
</html>
