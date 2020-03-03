<!DOCTYPE html>

{% set html_class = 'theme-next ' + theme.scheme %}
{% if theme.motion.enable %}
  {% set html_class = html_class + ' use-motion' %}
{% endif %}

<html class="{{ html_class | lower }}" lang="{{ config.language }}">
<head>
  {% include '_partials/head.swig' %}
  <title>{% block title %}{% endblock %}</title>
  {% include '_third-party/analytics/index.swig' %}
</head>

<body itemscope itemtype="http://schema.org/WebPage" lang="{{ page.lang || page.language || config.language }}">

  {% set container_class = "container " %}
  {% if theme.sidebar.position %}
    {% set container_class = container_class + 'sidebar-position-' + theme.sidebar.position %}
  {% endif %}

  <div class="{{ container_class }} {% block page_class %}{% endblock %}">
    <div class="headband">
	<a href="https://github.com/sanxiansheng" class="github-corner" aria-label="View source on GitHub"><svg width="80" height="80" viewBox="0 0 250 250" style="fill:#151513; color:#fff; position: absolute; top: 0; border: 0; right: 0;" aria-hidden="true"><path d="M0,0 L115,115 L130,115 L142,142 L250,250 L250,0 Z"></path><path d="M128.3,109.0 C113.8,99.7 119.0,89.6 119.0,89.6 C122.0,82.7 120.5,78.6 120.5,78.6 C119.2,72.0 123.4,76.3 123.4,76.3 C127.3,80.9 125.5,87.3 125.5,87.3 C122.9,97.6 130.6,101.9 134.4,103.2" fill="currentColor" style="transform-origin: 130px 106px;" class="octo-arm"></path><path d="M115.0,115.0 C114.9,115.1 118.7,116.5 119.8,115.4 L133.7,101.6 C136.9,99.2 139.9,98.4 142.2,98.6 C133.8,88.0 127.5,74.4 143.8,58.0 C148.5,53.4 154.0,51.2 159.7,51.0 C160.3,49.4 163.2,43.6 171.4,40.1 C171.4,40.1 176.1,42.5 178.8,56.2 C183.1,58.6 187.2,61.8 190.9,65.4 C194.5,69.0 197.7,73.2 200.1,77.6 C213.8,80.2 216.3,84.9 216.3,84.9 C212.7,93.1 206.9,96.0 205.4,96.6 C205.1,102.4 203.0,107.8 198.3,112.5 C181.9,128.9 168.3,122.5 157.7,114.1 C157.9,116.9 156.7,120.9 152.7,124.9 L141.0,136.5 C139.8,137.7 141.6,141.9 141.8,141.8 Z" fill="currentColor" class="octo-body"></path></svg></a><style>.github-corner:hover .octo-arm{animation:octocat-wave 560ms ease-in-out}@keyframes octocat-wave{0%,100%{transform:rotate(0)}20%,60%{transform:rotate(-25deg)}40%,80%{transform:rotate(10deg)}}@media (max-width:500px){.github-corner:hover .octo-arm{animation:none}.github-corner .octo-arm{animation:octocat-wave 560ms ease-in-out}}</style>
	</div>

    <header id="header" class="header" itemscope itemtype="http://schema.org/WPHeader">
      <div class="header-inner"> {%- include '_partials/header.swig' %} </div>
    </header>

    <main id="main" class="main">
      <div class="main-inner">
        <div class="content-wrap">
          <div id="content" class="content">
            {% block content %}{% endblock %}
          </div>
          {% include '_third-party/duoshuo-hot-articles.swig' %}
          {% include '_partials/comments.swig' %}
        </div>
        {% if theme.sidebar.display !== 'remove' %}
          {% block sidebar %}{% endblock %}
        {% endif %}
      </div>
    </main>

    <footer id="footer" class="footer">
      <div class="footer-inner">
        {% include '_partials/footer.swig' %}
        {% include '_third-party/analytics/analytics-with-widget.swig' %}
        {% block footer %}{% endblock %}
      </div>
    </footer>

    {% if not theme.sidebar.b2t %}
      <div class="back-to-top">
        <i class="fa fa-arrow-up"></i>
        {% if theme.sidebar.scrollpercent %}
          <span id="scrollpercent"><span>0</span>%</span>
        {% endif %}
      </div>
    {% endif %}

    {% if theme.needmoreshare2.enable and theme.needmoreshare2.float.enable %}
      <div id="needsharebutton-float">
        <span class="btn">
          <i class="fa fa-share-alt" aria-hidden="true"></i>
        </span>
      </div>
    {% endif %}

  </div>

  {% include '_scripts/vendors.swig' %}
  {% include '_scripts/commons.swig' %}

  {% set scheme_script = '_scripts/schemes/' + theme.scheme | lower + '.swig' %}
  {% include scheme_script %}

  {% block script_extra %}{% endblock %}

  {% include '_scripts/boostrap.swig' %}

  {% include '_third-party/comments/index.swig' %}
  {% include '_third-party/search/index.swig' %}
  {% include '_third-party/analytics/lean-analytics.swig' %}
  {% include '_third-party/analytics/firestore.swig' %}
  {% include '_third-party/seo/baidu-push.swig' %}
  {% include '_third-party/needsharebutton.swig' %}
  {% include '_third-party/rating.swig' %}
  {% include '_third-party/mathjax.swig' %}
  {% include '_third-party/scroll-cookie.swig' %}
  {% include '_third-party/exturl.swig' %}
</body>
</html>
<script type="text/javascript" src="/js/src/clicklove.js"></script>
<script>

// ! function() {    
//     //封装方法，压缩之后减少文件大小    
//     function get_attribute(node, attr, default_value) {    
//         return node.getAttribute(attr) || default_value;    
//     }    
//     //封装方法，压缩之后减少文件大小    
//     function get_by_tagname(name) {    
//         return document.getElementsByTagName(name);    
//     }    
//     //获取配置参数    
//     function get_config_option() {    
//         var scripts = get_by_tagname("script"),    
//             script_len = scripts.length,    
//             script = scripts[script_len - 1]; //当前加载的script    
//         return {    
//             l: script_len, //长度，用于生成id用    
//             z: get_attribute(script, "zIndex", -1), //z-index    
//             o: get_attribute(script, "opacity", 0.5), //opacity    
//             c: get_attribute(script, "color", "0,0,0"), //color    
//             n: get_attribute(script, "count", 99) //count    
//         };    
//     }    
//     //设置canvas的高宽    
//     function set_canvas_size() {    
//         canvas_width = the_canvas.width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth,     
//         canvas_height = the_canvas.height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;    
//     }    
    
//     //绘制过程    
//     function draw_canvas() {    
//         context.clearRect(0, 0, canvas_width, canvas_height);    
//         //随机的线条和当前位置联合数组    
//         var all_array = [current_point].concat(random_lines);    
//         var e, i, d, x_dist, y_dist, dist; //临时节点    
//         //遍历处理每一个点    
//         random_lines.forEach(function(r) {    
//             r.x += r.xa,     
//             r.y += r.ya, //移动    
//             r.xa *= r.x > canvas_width || r.x < 0 ? -1 : 1,     
//             r.ya *= r.y > canvas_height || r.y < 0 ? -1 : 1, //碰到边界，反向反弹    
//             context.fillRect(r.x - 0.5, r.y - 0.5, 1, 1); //绘制一个宽高为1的点    
//             for (i = 0; i < all_array.length; i++) {    
//                 e = all_array[i];    
//                 //不是当前点    
//                 if (r !== e && null !== e.x && null !== e.y) {    
//                         x_dist = r.x - e.x, //x轴距离 l    
//                         y_dist = r.y - e.y, //y轴距离 n    
//                         dist = x_dist * x_dist + y_dist * y_dist; //总距离, m    
//                     dist < e.max && (e === current_point && dist >= e.max / 2 && (r.x -= 0.03 * x_dist, r.y -= 0.03 * y_dist), //靠近的时候加速    
//                         d = (e.max - dist) / e.max,     
//                         context.beginPath(),     
//                         context.lineWidth = d / 2,     
//                         context.strokeStyle = "rgba(" + config.c + "," + (d + 0.2) + ")",     
//                         context.moveTo(r.x, r.y),     
//                         context.lineTo(e.x, e.y),     
//                         context.stroke());    
//                 }    
//             }    
//             all_array.splice(all_array.indexOf(r), 1);    
    
//         }), frame_func(draw_canvas);    
//     }    
//     //创建画布，并添加到body中    
//     var the_canvas = document.createElement("canvas"), //画布    
//         config = get_config_option(), //配置    
//         canvas_id = "c_n" + config.l, //canvas id    
//         context = the_canvas.getContext("2d"), canvas_width, canvas_height,     
//         frame_func = window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame || function(func) {    
//             window.setTimeout(func, 1000 / 45);    
//         }, random = Math.random,     
//         current_point = {    
//             x: null, //当前鼠标x    
//             y: null, //当前鼠标y    
//             max: 20000    
//         };    
//     the_canvas.id = canvas_id;    
//     the_canvas.style.cssText = "position:fixed;top:0;left:0;z-index:" + config.z + ";opacity:" + config.o;    
//     get_by_tagname("body")[0].appendChild(the_canvas);    
//     //初始化画布大小    
    
//     set_canvas_size(), window.onresize = set_canvas_size;    
//     //当时鼠标位置存储，离开的时候，释放当前位置信息    
//     window.onmousemove = function(e) {    
//         e = e || window.event, current_point.x = e.clientX, current_point.y = e.clientY;    
//     }, window.onmouseout = function() {    
//         current_point.x = null, current_point.y = null;    
//     };    
//     //随机生成config.n条线位置信息    
//     for (var random_lines = [], i = 0; config.n > i; i++) {    
//         var x = random() * canvas_width, //随机位置    
//             y = random() * canvas_height,    
//             xa = 2 * random() - 1, //随机运动方向    
//             ya = 2 * random() - 1;    
//         random_lines.push({    
//             x: x,    
//             y: y,    
//             xa: xa,    
//             ya: ya,    
//             max: 6000 //沾附距离    
//         });    
//     }    
//     //0.1秒后绘制    
//     setTimeout(function() {    
//         draw_canvas();    
//     }, 100);    
// }();    


</script>