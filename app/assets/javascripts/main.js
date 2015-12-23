//
// main js
// --------------------------------------------------
//

var $ = jQuery.noConflict();

(function($) {
  'use strict';

//
// function start
// --------------------------------------------------
//

//
// variable
// --------------------------------------------------
//

  var $html = $('html');
  var $body = $('body');
  var $linkBtn = $('[data-link="section"]');
  var $linkMenu = $('.site-nav__menu').find('a');
  var $link = $linkBtn.add($linkMenu);

//
// ie10 viewport fix
// --------------------------------------------------
//

  (function() {
    'use strict';
    if (navigator.userAgent.match(/IEMobile\/10\.0/)) {
      var msViewportStyle = document.createElement('style')
      msViewportStyle.appendChild(
        document.createTextNode(
          '@-ms-viewport{width:auto!important}'
        )
      )
      document.querySelector('head').appendChild(msViewportStyle)
    }
  })();

//
// core
// --------------------------------------------------
//
  // device detect
  if (!$html.hasClass('desktop')) {
    var isMobile = true;
    $html.addClass('is-mobile');
  } else {
    var isMobile = false;
    $html.addClass('is-desktop');
  }

  // browser detect
  if ($html.hasClass('ie9')) {
    var isIE9 = true;
  }

  // click event
  $('a[href=#]').on('click', function(e) {
    e.preventDefault();
  });

  // clone social
  $('.site-footer__social').clone().removeClass('site-footer__social').addClass('site-nav__social').insertAfter('.site-nav__menu');

  // border
  if (_site_border) {
    $body.addClass('border-on');
  }

//
// countdown
// --------------------------------------------------
//

  function fn_countdown() {
    var $countdown = $('#countdown_dashboard');

    if (_countdown) {
      if ($countdown.length) {
        $body.addClass('countdown-on');

        $countdown.countDown({
          targetDate: {
            'day':      _countdown_date[2],
            'month':    _countdown_date[1],
            'year':     _countdown_date[0],
            'hour':     0,
            'min':      0,
            'sec':      0,
            'utc':      _countdown_utc // time set as UTC
          },
          omitWeeks: true // 3-digit days
        });
      }
    } else {
      $countdown.remove();
    }
  }
  fn_countdown();

//
// site loader
// --------------------------------------------------
//

  function fn_siteLoader() {
    var id;    

    id = '#' + $('.section').filter('.is-active').attr('id');
    $('a[href="' + id + '"]').addClass('is-active');

    fn_scrollbar();

    if ($html.hasClass('cssanimations')) {
      $(id).find('[data-animation-in]').each(function() {
        var $this = $(this);
        var animationIn = 'fadeIn';
        var animationInDelay = 1;

        if ($this.data('animation-in')) {
          animationIn = $this.data('animation-in');
        }

        if ($this.data('animation-in-delay')) {
          animationInDelay = $this.data('animation-in-delay');
        }

        $this.css('animation-delay', animationInDelay + 500 + 'ms').addClass('animated').addClass(animationIn);
      });
    }

    $body.addClass(id.replace('#', '') + '-in');

    $('.site-loader').velocity('fadeOut', {
      queue: false,
      delay: 500,
      duration: 800,
      complete: function() {
        $body.addClass('is-loaded');
      }
    });
  }

//
// nav
// --------------------------------------------------
//

  function fn_siteNav() {
    $('.site-header__icon__nav').find('a').add($linkMenu).on('click', function(e) {
      e.preventDefault();
      fn_siteNavAnimation();
    });
  }

  function fn_siteNavAnimation() {
    var $siteNav = $('.site-nav');
    $body.toggleClass('nav-in');

    if ($body.hasClass('nav-in')) {
      $siteNav.velocity('stop', true)
      .velocity('fadeIn', {
        duration: 500
      });

      $('.site-nav__inner').velocity('stop', true)
      .velocity({
        translateY: ['0', '-25%'],
        rotateX: ['0deg', '35deg'],
        opacity: ['1', '.4']
      }, {
        duration: 500
      });
    } else {
      $siteNav.velocity('stop', true)
      .velocity('fadeOut', {
        duration: 500
      });

      $('.site-nav__inner').velocity('stop', true)
      .velocity({
        translateY: ['25%', '0'],
        rotateX: ['-35deg', '0deg'],
        opacity: ['.4', '1']
      }, {
        duration: 500
      });
    }
  }
  fn_siteNav();

//
// menu
// --------------------------------------------------
//

  function fn_menu() {
    var $section = $('.section');
    var ids = [];

    $section.each(function() {
      ids.push(this.id);
    });

    $link.on('click', function(e) {
      var $this = $(this);
      var id = $this.attr('href');
      var animationDelay = 1;

      e.preventDefault();

      if (!$(id).length || $this.hasClass('is-active')) {
        return false;
      }

      if ($body.hasClass('is-loaded')) {
        if (!$body.hasClass('animating')) {
          $link.filter('.is-active').removeClass('is-active');

          fn_animationOut();

          if ($html.hasClass('cssanimations')) {
            $section.filter('.is-active').find('[data-animation-out]').each(function() {
              var animationOutDelay = $(this).data('animation-out-delay');

              if (animationOutDelay) {
                animationDelay = animationOutDelay > animationDelay ? animationOutDelay : animationDelay
              }
            });
          }

          $('.site-loader').velocity('fadeIn', {
            queue: false,
            delay: animationDelay + 500,
            duration: 800,
            complete: function() {
              $body.removeClass('animating');

              $('.site-wrap').scrollTop(0);
              $('.site-wrap').perfectScrollbar('update');

              $('.section').filter('.is-active').removeClass('is-active');
              $(id).addClass('is-active');
              $('a[href="' + id + '"]').addClass('is-active');
              $.each(ids, function(i, v) {
                $body.removeClass(v + '-in');
              });
              $body.addClass(id.replace('#', '') + '-in');
              $('.form-group').removeClass('error');
              $('.form-notify').removeClass('valid error').html('').hide();

              $(this).velocity('fadeOut', {
                delay: 100,
                duration: 800,
              });

              setTimeout(function() {
                fn_scrollbar();
                fn_animationIn();
              }, 0);
            }
          });
        }
      }
    });
  }
  fn_menu();
//
// animation
// --------------------------------------------------
//

  function fn_animationIn() {
    var $activeSection = $('.section').filter('.is-active');

    $activeSection.find('[data-animation-in]').each(function() {
      var $this = $(this);
      var animationIn = 'fadeIn';
      var animationInDelay = 100;

      if ($this.data('animation-in')) {
        animationIn = $this.data('animation-in');
      }

      if ($this.data('animation-in-delay')) {
        animationInDelay = $this.data('animation-in-delay');
      }

      $this.css('animation-delay', animationInDelay + 'ms').addClass('animated').addClass(animationIn);
    });
  }

  function fn_animationOut() {
    var animationDelay = 1;

    $body.addClass('animating');

    $('[data-animation-out]').each(function() {
      var $this = $(this);
      var animationIn = 'fadeIn';
      var animationOut = 'fadeOut';
      var animationInDelay = 100;
      var animationOutDelay = 1;

      if ($this.data('animation-in')) {
        animationIn = $this.data('animation-in');
      }

      if ($this.data('animation-out')) {
        animationOut = $this.data('animation-out');
      }

      if ($this.data('animation-in-delay')) {
        animationInDelay = $this.data('animation-in-delay');
      }

      if ($this.data('animation-out-delay')) {
        animationOutDelay = $this.data('animation-out-delay');
      }

      $this.css('animation-delay', animationInDelay + 'ms');

      if ($this.closest('.section').hasClass('is-active')) {
        $this.removeClass(animationIn).addClass(animationOut);

        if ($this.data('animation-out-delay')) {
          $this.css('animation-delay', animationOutDelay + 'ms');
        } else {
          $this.css('animation-delay', '1ms');
        }
      } else {
        $this.removeClass(animationIn).removeClass(animationOut).removeAttr('style', 'animation-delay');
      }
    });
  }

//
// scrollbar
// --------------------------------------------------
//

  function fn_scrollbar() {
    var $scrollBlock = $('.site-wrap');

    if (!isMobile) {
      $scrollBlock.perfectScrollbar({
        suppressScrollX: true
      });
    }
  }

//
// contact
// --------------------------------------------------
//

  function fn_contact() {
    var $form = $('#formContact');
    var $formNotify = $form.find('.form-notify');

    $form.validate({
      onfocusout: false,
      onkeyup: false,
      onclick: false,
      rules: {
        name: {
          required: true
        },
        email: {
          required: true,
          email: true
        },
        message: {
          required: true
        }
      },
      messages: {
        //name: 'Enter your name',
        //email: 'Enter your email address',
        //message: 'Enter message'
      },
      errorPlacement: function(error, element) {},
      highlight: function(element) {
        $(element).parent('.form-group').addClass('error');
      },
      unhighlight: function(element) {
        $(element).parent('.form-group').removeClass('error');
      },
      submitHandler: function(form) {
        $(form).ajaxSubmit({
          type: 'POST',
          url: 'assets/php/contact.php',
          dataType: 'json',
          cache: false,
          data: $form.serialize(),
          success: function(data) {
            if (data.code == 0) {
              $form.validate().resetForm();
              $form[0].reset();
              $form.find('.form-label').removeClass('error');
              $form.find('button').blur();
              $formNotify.removeClass('valid error').addClass('valid').html(data.message).show();
            } else {
              $formNotify.removeClass('valid error').addClass('error').html(data.message).show();
            }
          },
          error: function(data) {
            $formNotify.removeClass('valid').addClass('error').html('An error occurred. Please try again later.').show();
          },
        });
      },
      invalidHandler: function(event, validator) {
        var errors = validator.numberOfInvalids();
        if (errors) {
          var message = errors == 1
            ? 'You missed 1 field. It has been highlighted.'
            : 'You missed ' + errors + ' fields. They have been highlighted.';
          $formNotify.removeClass('valid error').addClass('error').html(message).show();
        }
      }
    });
  }
  fn_contact();

  function fn_newsletter() {
    // popup
    var $btn = $('a[href="#newsletter"]');
    var $form = $('#formNewsletter');
    var $formNotify = $form.find('.form-notify');
    var magnificPopupNewsletter =
    {
      //closeMarkup: '<button title="%title%" type="button" class="mfp-close_c"></button>',
      closeMarkup: '<div class="mfp-close_c mfp-close"></div>',
      type: 'inline',
      overflowY: 'scroll',
      removalDelay: 500,
      mainClass: 'mfp-effect',
      preloader: false,
      focus: 'input',
      callbacks: {
        beforeOpen: function() {
          if($(window).width() < 768) {
            this.st.focus = false;
          } else {
            this.st.focus = '#newsletterEmail';
          }
          //this.st.mainClass = this.st.el.attr('data-effect');

          $body.addClass('newsletter-in');
        },
        beforeClose: function() {
          $body.removeClass('newsletter-in');
        },
        afterClose: function() {
          $btn.blur();
          $form.find('.form-group').removeClass('error');
          $formNotify.removeClass('valid error').html('').hide();
        }
      },
      midClick: true
    }

    $btn.magnificPopup(magnificPopupNewsletter);

    // form valid
    $form.validate({
      onfocusout: false,
      onkeyup: false,
      onclick: false,
      rules: {
        email: {
          required: true,
          email: true
        }
      },
      messages: {
        //email: 'Enter your email address',
      },
      errorPlacement: function(error, element) {},
      highlight: function(element) {
        $(element).parent('.form-group').addClass('error');
      },
      unhighlight: function(element) {
        $(element).parent('.form-group').removeClass('error');
      },
      submitHandler: function(form) {
        $(form).ajaxSubmit({
          type: 'POST',
          url: 'assets/php/newsletter.php',
          dataType: 'json',
          cache: false,
          data: $form.serialize(),
          success: function(data) {
            if (data.code == 0) {
              $form.validate().resetForm();
              $form[0].reset();
              $form.find('.form-label').removeClass('error');
              $form.find('button').blur();
              $formNotify.removeClass('error').addClass('valid').html(data.message).show();
            } else {
              $formNotify.removeClass('valid').addClass('error').html(data.message).show();
            }
          },
          error: function(data) {
            $formNotify.removeClass('valid').addClass('error').html('An error occurred. Please try again later.').show();;
          },
        });
      },
      invalidHandler: function(event, validator) {
        var errors = validator.numberOfInvalids();
        if (errors) {
          var message = errors == 1
            ? 'You missed 1 field. It has been highlighted.'
            : 'You missed ' + errors + ' fields. They have been highlighted.';
          $formNotify.removeClass('valid').addClass('error').html(message).show();
        }
      }
    });
  }
  fn_newsletter();

//
// site background
// --------------------------------------------------
//

  function fn_siteBg() {
    // mobile
    if (isMobile) {
      if (_bg_style_mobile == 3 || _bg_style_mobile == 4) {
        fn_siteBgImg();
      }
      else if (_bg_style_mobile == 5 || _bg_style_mobile == 6 || _bg_style_mobile == 7 || _bg_style_mobile == 8) {
        $(window).on('load', function() {
          fn_siteBgSlideshow();
        });
      }
    }

    // desktop
    else {
      if (_bg_style_desktop == 3 || _bg_style_desktop == 4) {
        fn_siteBgImg();
      }
      else if (_bg_style_desktop == 5 || _bg_style_desktop == 6 || _bg_style_desktop == 7 || _bg_style_desktop == 8) {
        fn_siteBgSlideshow();
      }
      else if (_bg_style_desktop == 9 || _bg_style_desktop == 10 || _bg_style_desktop == 11) {
        fn_siteBgVideo();
      }
      else if (_bg_style_desktop == 12 || _bg_style_desktop == 13 || _bg_style_desktop == 14) {
        fn_siteBgVideoYoutube();
      }
    }
  }
  fn_siteBg();

//
// image background
// --------------------------------------------------
//

  function fn_siteBgImg() {
    $('.site-bg__video').remove();

    $body.addClass('is-site-bg-img');
  }

//
// slideshow background
// --------------------------------------------------
//

  function fn_siteBgSlideshow() {
    var $siteBgImg = $('.site-bg__img');

    $('.site-bg__video').remove();

    $body.addClass('is-site-bg-slideshow');
    for (var i = 1; i <= _bg_slideshow_image_amount; i++) {
      $siteBgImg.append('<img src="assets/img/bg/site-bg-slideshow-' + (i < 10 ? '0' + i : i) + '.jpg">');
    }

    if (isMobile) {
      if (_bg_style_mobile == 5 || _bg_style_mobile == 6) {
        fn_ss();
      } else if (_bg_style_mobile == 7 || _bg_style_mobile == 8) {
        fn_kenburnsy();
      }
    }
    else {
      if (_bg_style_desktop == 5 || _bg_style_desktop == 6) {
        fn_ss();
      } else if (_bg_style_desktop == 7 || _bg_style_desktop == 8) {
        fn_kenburnsy();
      }
    }

    function fn_ss() {
      $siteBgImg.ss({
        fullscreen: true,
        duration: _bg_slideshow_duration,
        fadeInDuration: 1500
      });
    }

    function fn_kenburnsy() {
      $siteBgImg.kenburnsy({
        fullscreen: true,
        duration: _bg_slideshow_duration,
        fadeInDuration: 1500
      });
    }
  }

//
// html5 video background
// --------------------------------------------------
//

  function fn_siteBgVideo() {
    var $video = $('.site-bg__video');
    var $audio = $('.site-header__icon__audio');

    $body.addClass('is-site-bg-video');

    $video.append('<video id="videoPlayer" autoplay loop>' +
                  '<source src="assets/video/video.mp4" type="video/mp4">' +
                  '</video>');

    var videoPlayer = document.getElementById('videoPlayer');

    if (_bg_style_desktop == 9) {
      videoPlayer.muted = true;
      $audio.remove();
    } else if (_bg_style_desktop == 10) {
      $body.addClass('is-audio-on');

      $audio.on('click', function() {
        if ($body.hasClass('is-audio-on')) {
          videoPlayer.muted = true;
          $body.removeClass('is-audio-on').addClass('is-audio-off');
        } else if ($body.hasClass('is-audio-off')) {
          videoPlayer.muted = false;
          $body.removeClass('is-audio-off').addClass('is-audio-on');
        }
      });
    }
  }

//
// youtube video background
// --------------------------------------------------
//

  function fn_siteBgVideoYoutube() {
    var $video = $('.site-bg__video');
    var $audio = $('.site-header__icon__audio');

    $body.addClass('is-site-bg-video-youtube');
    if (_bg_style_desktop == 12 || _bg_style_desktop == 14) {
      $video.attr('data-property', '{videoURL: _bg_video_youtube_url, autoPlay: true, loop: _bg_video_youtube_loop, startAt: _bg_video_youtube_start, stopAt: _bg_video_youtube_end, mute: true, quality: _bg_video_youtube_quality, realfullscreen: true, optimizeDisplay: true, addRaster: false, showYTLogo: false, showControls: false, stopMovieOnBlur: false, containment: "self"}');
      $video.YTPlayer();
    } else {
      $video.attr('data-property', '{videoURL: _bg_video_youtube_url, autoPlay: true, loop: _bg_video_youtube_loop, startAt: _bg_video_youtube_start, stopAt: _bg_video_youtube_end, mute: false, quality: _bg_video_youtube_quality, realfullscreen: true, optimizeDisplay: true, addRaster: false, showYTLogo: false, showControls: false, stopMovieOnBlur: false, containment: "self"}');
      $video.YTPlayer();

      $body.addClass('is-audio-on');

      $audio.on('click', function() {
        if ($body.hasClass('is-audio-on')) {
          $video.YTPMute()
          $body.removeClass('is-audio-on').addClass('is-audio-off');
        } else if ($body.hasClass('is-audio-off')) {
          $video.YTPUnmute()
          $body.removeClass('is-audio-off').addClass('is-audio-on');
        }
      });
    }
  }

//
// background audio
// --------------------------------------------------
//

  function fn_siteBgAudio() {
    if (_bg_style_mobile == 2 || _bg_style_mobile == 4 || _bg_style_mobile == 6 || _bg_style_mobile == 8 || _bg_style_desktop == 2 || _bg_style_desktop == 4 || _bg_style_desktop == 6 || _bg_style_desktop == 8 || _bg_style_desktop == 11 || _bg_style_desktop == 14) {
      $body.append('<audio id="audioPlayer" loop>' +
                   '<source src="assets/audio/audio.mp3" type="audio/mpeg">' +
                   '</audio>');
    }

    if (isMobile) {
      if (_bg_style_mobile == 2 || _bg_style_mobile == 4 || _bg_style_mobile == 6 || _bg_style_mobile == 8) {
        $body.addClass('is-audio-off');
        fn_siteBgAudioControl();
      }
    } else {
      if (_bg_style_desktop == 2 || _bg_style_desktop == 4 || _bg_style_desktop == 6 || _bg_style_desktop == 8 || _bg_style_desktop == 11 || _bg_style_desktop == 14) {
        var $audioPlayer = document.getElementById('audioPlayer');

        $body.addClass('is-audio-on');
        $audioPlayer.play();
        fn_siteBgAudioControl();
      }
    }

    function fn_siteBgAudioControl() {
      var $audio = $('.site-header__icon__audio');
      var $audioPlayer = document.getElementById('audioPlayer');

      $audio.on('click', function() {
        var $this = $(this);

        if ($body.hasClass('is-audio-on')) {
          $audioPlayer.pause();
          $body.removeClass('is-audio-on').addClass('is-audio-off');
        } else if ($body.hasClass('is-audio-off')) {
          $audioPlayer.play();
          $body.removeClass('is-audio-off').addClass('is-audio-on');
        }
      });
    }
  }
  fn_siteBgAudio();

//
// background effect
// --------------------------------------------------
//

  function fn_siteBgEffect() {
    if (_bg_effect == 0) {
      $('.site-bg__canvas').remove();
    } else if (_bg_effect == 1) {
      fn_siteBgCloud();
    } else if (_bg_effect == 2) {
      fn_siteBgParallaxStar();
    } else if (_bg_effect == 3) {
      fn_siteBgStar();
    }
  }

  function fn_siteBgCloud() {
    var $siteBgEffect = $('.site-bg__effect');
    $('.site-bg__canvas').remove();
    $siteBgEffect.css('opacity', _cloud_opacity);

    if ($siteBgEffect.length) {
      $siteBgEffect.append(
        '<div class="cloud cloud-01"></div>' +
        '<div class="cloud cloud-02"></div>' +
        '<div class="cloud cloud-03"></div>'
      )

      $body.addClass('is-site-bg-cloud');

      fn_cloud01();
      fn_cloud02();
      fn_cloud03();
    }
  }

  function fn_cloud01() {
    var $cloud = $('.cloud-01');

    $cloud.velocity({
      translateZ: '0',
      translateX: ['-100%', '100%']
    }, {
      duration: 25000,
      ease: 'liner',
      queue: false,
      complete: function() {
        $(this).velocity({
          translateX: '100%'
        }, {
          duration: 0,
          queue: false,
          complete: fn_cloud01
        });
      }
    });
  }

  function fn_cloud02() {
    var $cloud = $('.cloud-02');

    $cloud.velocity({
      translateZ: '0',
      translateX: ['-100%', '100%']
    }, {
      duration: 35000,
      ease: 'liner',
      queue: false,
      complete: function() {
        $(this).velocity({
          translateX: '100%'
        }, {
          duration: 0,
          queue: false,
          complete: fn_cloud02
        });
      }
    });
  }

  function fn_cloud03() {
    var $cloud = $('.cloud-03');

    $cloud.velocity({
      translateZ: '0',
      translateX: ['-100%', '100%']
    }, {
      duration: 45000,
      ease: 'liner',
      queue: false,
      complete: function() {
        $(this).velocity({
          translateX: '100%'
        }, {
          duration: 0,
          queue: false,
          complete: fn_cloud03
        });
      }
    });
  }

  function fn_siteBgParallaxStar() {
    var $siteBgEffect = $('.site-bg__effect');
    $('.site-bg__canvas').remove();
    $siteBgEffect.css('opacity', 0);

    if ($siteBgEffect.length) {
      $siteBgEffect.append(
        '<div class="star star-01"></div>' +
        '<div class="star star-02"></div>' +
        '<div class="star star-03"></div>'
      )

      $body.addClass('is-site-bg-parallax-star');

      fn_star01();
      fn_star02();
      fn_star03();

      $(window).on('load', function() {
        setTimeout(function () {
          $siteBgEffect.velocity({
            translateZ: '0',
            opacity: [_parallax_star_opacity, '0'],
          }, {
            display: 'block',
            duration: 3000
          });
        }, 2000);
      });
    }
  }

  function fn_star01() {
    var $star = $('.star-01');

    $star.velocity({
      translateZ: '0',
      translateY: ['-2000px', '0']
    }, {
      duration: 50000,
      ease: 'liner',
      queue: false,
      complete: function() {
        $(this).velocity({
          translateY: '0'
        }, {
          duration: 0,
          queue: false,
          complete: fn_star01
        });
      }
    });
  }

  function fn_star02() {
    var $star = $('.star-02');

    $star.velocity({
      translateZ: '0',
      translateY: ['-2000px', '0']
    }, {
      duration: 100000,
      ease: 'liner',
      queue: false,
      complete: function() {
        $(this).velocity({
          translateY: '0'
        }, {
          duration: 0,
          queue: false,
          complete: fn_star02
        });
      }
    });
  }

  function fn_star03() {
    var $star = $('.star-03');

    $star.velocity({
      translateZ: '0',
      translateY: ['-2000px', '0']
    }, {
      duration: 150000,
      ease: 'liner',
      queue: false,
      complete: function() {
        $(this).velocity({
          translateY: '0'
        }, {
          duration: 0,
          queue: false,
          complete: fn_star03
        });
      }
    });
  }

  function fn_siteBgStar() {
    var $canvas = $('.site-bg__canvas');

    $body.addClass('is-site-bg-star');

    function callCanvas (canvas) {
      var screenpointSplitt = 12000
      var movingSpeed = 0.2
      var viewportWidth = $(window).width();
      var viewportHeight = $(window).height();
      var nbCalculated = Math.round(viewportHeight*viewportWidth/screenpointSplitt);

      var $this = $(this),
      ctx = canvas.getContext('2d');
      $this.config = {
        star: {
          color: _bg_effect_star_color,
          width: _bg_effect_star_width
        },
        line: {
          color: _bg_effect_star_color,
          width: 0.4
        },
        position: {
          x: canvas.width * 0.5,
          y: canvas.height * 0.5
        },
        velocity: movingSpeed,
        length: nbCalculated,
        distance: 130,
        radius: 120,
        stars: []
      };

      function Star () {
        this.x = Math.random() * canvas.width;
        this.y = Math.random() * canvas.height;

        this.vx = ($this.config.velocity - (Math.random() * 0.3));
        this.vy = ($this.config.velocity - (Math.random() * 0.3));

        this.radius = Math.random() * $this.config.star.width;
      }

      Star.prototype = {
        create: function(){
          ctx.beginPath();
          ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2, false);
          ctx.fill();
        },

        animate: function(){
          var i;
          for(i = 0; i < $this.config.length; i++){

            var star = $this.config.stars[i];

            if(star.y < 0 || star.y > canvas.height){
              star.vx = star.vx;
              star.vy = - star.vy;
            }
            else if(star.x < 0 || star.x > canvas.width){
              star.vx = - star.vx;
              star.vy = star.vy;
            }
            star.x += star.vx;
            star.y += star.vy;
          }
        },

        line: function(){
          var length = $this.config.length,
            iStar,
            jStar,
            i,
            j;

          for(i = 0; i < length; i++){
            for(j = 0; j < length; j++){
              iStar = $this.config.stars[i];
              jStar = $this.config.stars[j];

              if(
                (iStar.x - jStar.x) < $this.config.distance &&
                (iStar.y - jStar.y) < $this.config.distance &&
                (iStar.x - jStar.x) > - $this.config.distance &&
                (iStar.y - jStar.y) > - $this.config.distance
              ) {
                if(
                  (iStar.x - $this.config.position.x) < $this.config.radius &&
                  (iStar.y - $this.config.position.y) < $this.config.radius &&
                  (iStar.x - $this.config.position.x) > - $this.config.radius &&
                  (iStar.y - $this.config.position.y) > - $this.config.radius
                ) {
                  ctx.beginPath();
                  ctx.moveTo(iStar.x, iStar.y);
                  ctx.lineTo(jStar.x, jStar.y);
                  ctx.stroke();
                  ctx.closePath();
                }

              }
            }
          }
        }

      };
      $this.createStars = function () {
        var length = $this.config.length,
          star,
          i;

        ctx.clearRect(0, 0, canvas.width, canvas.height);
        for(i = 0; i < length; i++){
          $this.config.stars.push(new Star());
          star = $this.config.stars[i];
          star.create();
        }

        star.line();
        star.animate();
      };

      $this.setCanvas = function () {
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;
      };

      $this.setContext = function () {
        ctx.fillStyle = $this.config.star.color;
        ctx.strokeStyle = $this.config.line.color;
        ctx.lineWidth = $this.config.line.width;
        ctx.fill();
      };

      $this.loop = function (callback) {
        callback();
        reqAnimFrame(function () {
          $this.loop(function () {
            callback();
          });
        });
      };

      $this.bind = function () {
        $(window).on('mousemove', function(e){
          $this.config.position.x = e.pageX;
          $this.config.position.y = e.pageY;
        });
      };

      $this.init = function () {
        $this.setCanvas();
        $this.setContext();

        $this.loop(function () {
          $this.createStars();
        });

        $this.bind();
      };

      return $this;
    }

    var reqAnimFrame = window.requestAnimationFrame || window.mozRequestAnimationFrame || window.webkitRequestAnimationFrame || window.msRequestAnimationFrame || function (callback) {
      window.setTimeout(callback, 1000 / 60);
    };

    $(window).on('load', function() {
      setTimeout(function () {
        callCanvas($('canvas')[0]).init();
        $canvas.velocity('transition.fadeIn', {
          duration: 3000
        });
      }, 2000);
    });

    var waitForFinalEvent = (function () {
      var timers = {};
      return function (callback, ms, uniqueId) {
      if (!uniqueId) {
        uniqueId = '';
      }
      if (timers[uniqueId]) {
        clearTimeout (timers[uniqueId]);
      }
      timers[uniqueId] = setTimeout(callback, ms);
      };
    })();

    $(window).resize(function () {
      waitForFinalEvent(function(){
        callCanvas($('canvas')[0]).init();
      }, 800, '');
    });
  }
  fn_siteBgEffect();

//
// image preload
// --------------------------------------------------
//

  function fn_imgLoaded() {
    if (isMobile) {
      if (_bg_style_mobile == 1 || _bg_style_mobile == 2) {
        fn_imgLoad();
      } else {
        fn_siteLoader();
      }
    } else {
      if (_bg_style_desktop == 1 || _bg_style_desktop == 2) {
        fn_imgLoad();
      } else {
        fn_siteLoader();
      }
    }

    function fn_imgLoad() {
      var imgSet = ['assets/img/bg/home.jpg',
                    'assets/img/bg/about.jpg',
                    'assets/img/bg/service.jpg',
                    'assets/img/bg/contact.jpg'];
      var imgArray = [];

      var i;
      for (i = 0; i < imgSet.length; i++) {
        var img = new Image();
        img.src = imgSet[i];
        imgArray[i] = img;
      }

      var imgLoad = imagesLoaded(imgArray);

      $body.addClass('is-each');
      $('.site-bg__video').remove();

      imgLoad.on('always', function (instance) {
        fn_siteLoader();
      });
    }
  }
  $(window).on('load', function() {
    fn_imgLoaded();
  });

//
// service
// --------------------------------------------------
//

  function fn_service() {
    // service
    var $serviceCarousel = $('#serviceCarousel');

    if ($serviceCarousel.length) {
      $serviceCarousel.owlCarousel({
        rewind: true,
        nav: true,
        navText: ['' , ''],
        navContainer: '.service__carousel-control',
        navContainerClass: 'carousel-nav',
        navClass: [ 'carousel-prev', 'carousel-next' ],
        dots: false,
        margin: 30,
        responsive: {
          0: {
            items: 1
          },
          768: {
            items: 2
          },
          992: {
            items: 3
          }
        }
      });
    }
  }
  fn_service();

//
// function end
// --------------------------------------------------
//

})(jQuery);