/**
 * Created by Administrator on 2017-1-17.
 * Design nas  ^^
 */

$(document).ready(function () {
    //------------ 스크롤과 상관없이 효과가 발생하는 부분----------


    $('#plusminus').stop().fadeIn();
    $('#main .objs.bt_obj li:nth-child(1)').stop().delay(500).animate({marginLeft:-223,top:247,opacity:1},1500,'easeOutBack');
    $('#main .objs.bt_obj li:nth-child(3)').stop().delay(1500).animate({marginLeft:-300,bottom:95,opacity:1},2000);
    $('#main .objs.bt_obj li:nth-child(2)').stop().delay(2400).animate({opacity:1});
    $('.plus.masking > img').stop().delay(500).animate({left:0,opacity:1},1500);
    $('.minus.masking > img').stop().delay(1300).animate({right:0,opacity:1},1500);
    $('#main .objs.mid_obj li:nth-child(1)').stop().delay(1000).animate({opacity:1});





    //둥실둥실                                      속도      이동거리     횟수(-1무제한 ) 왔다갔다
    TweenMax.to($('#main .objs.bt_obj li:nth-child(1)'), 1, {marginTop: 7, repeat: -1, yoyo: true, repeatDelay: 0,ease: Quad.easeInOut});
    TweenMax.to($('#main .objs.bt_obj li:nth-child(2)'), 0.8, {marginTop: 10, repeat: -1, yoyo: true, repeatDelay: 0,ease: Quad.easeInOut});
    TweenMax.to($('#main .objs.top_obj li:nth-child(1)'), 0.9, {marginTop: 6, repeat: -1, yoyo: true, repeatDelay: 0,ease: Quad.easeInOut});
    TweenMax.to($('#main .objs.top_obj li:nth-child(2)'), 0.8, {marginTop: 8, repeat: -1, yoyo: true, repeatDelay: 0,ease: Quad.easeInOut});
    TweenMax.to($('#main .objs.top_obj li:nth-child(3)'), 1, {marginTop: 6, repeat: -1, yoyo: true, repeatDelay: 0,ease: Quad.easeInOut});
    TweenMax.to($('#main .objs.top_obj li:nth-child(4)'), 1.1, {marginTop: 8, repeat: -1, yoyo: true, repeatDelay: 0,ease: Quad.easeInOut});

    //씬2 둥실
    TweenMax.to($('#mobile_obj li:nth-child(1)'), 0.8, {marginTop: 8, repeat: -1, yoyo: true, repeatDelay: 0,ease: Quad.easeInOut});
    TweenMax.to($('#mobile_obj li:nth-child(2)'), 1, {marginTop: 9, repeat: -1, yoyo: true, repeatDelay: 0,ease: Quad.easeInOut});
    TweenMax.to($('#mobile_obj li:nth-child(3)'), 0.9, {marginTop: 10, repeat: -1, yoyo: true, repeatDelay: 0,ease: Quad.easeInOut});
    TweenMax.to($('#mobile_obj li:nth-child(4)'), 1, {marginTop: 7, repeat: -1, yoyo: true, repeatDelay: 0,ease: Quad.easeInOut});

    //씬3 둥실
    TweenMax.to($('#minus_cont .objs.minus_obj li:nth-child(3)'), 1.5, {marginTop: 15, repeat: -1, yoyo: true, repeatDelay: 0,ease: Quad.easeInOut});
    TweenMax.to($('#minus_cont .objs.minus_obj li:nth-child(2)'), 1.1, {marginTop: 7, repeat: -1, yoyo: true, repeatDelay: 0,ease: Quad.easeInOut});
    TweenMax.to($('#minus_cont .objs.minus_obj li:nth-child(1)'), 1, {marginTop: 10, repeat: -1, yoyo: true, repeatDelay: 0,ease: Quad.easeInOut});


    // plus
    $('#plus .bg_box li .more_arrow > img').on('click',function () {
        $('#plus_cont').stop().css({'display':'block'}).animate({left:0,opacity:1},800);
        $('#main').stop().animate({left:600},800);
        $('#main > div .bg_box li .more_arrow > img').stop().css({'display':'none'});
        $('#minus_cont').stop().css({'display':'none'});
        $('#main .objs.btns').stop().css({'display':'none'});
        $('#home_close').stop().css({'display':'none'});
        $('#plus_cont .objs.plus_obj li:nth-child(1)').stop().delay(800).animate({marginLeft:-634,top:0,opacity:1},1500,'easeOutBack');
    });
    $('#plus_cont .back_btn').on('click',function () {
        $('#plus_cont').stop().animate({left:-600,opacity:0},1000);
        $('#main').stop().animate({left:0},500);
        $('#main > div .bg_box li .more_arrow > img').stop().css({'display':'block'});
        $('#minus_cont').stop().css({'display':'none'}).animate({right:-600,opacity:0});
        $('#main .objs.btns').stop().css({'display':'block'});
        $('#home_close').stop().css({'display':'block'});
    });
    // minus
    $('#minus .bg_box li .more_arrow > img').on('click',function () {
        $('#minus_cont').stop().css({'display':'block'}).animate({right:0,opacity:1},800);
        $('#main').stop().animate({left:-600},800);
        $('#main > div .bg_box li .more_arrow > img').stop().css({'display':'none'});
        $('#plus_cont').stop().css({'display':'none'});
        $('#main .objs.btns').stop().css({'display':'none'});
        $('#home_close').stop().css({'display':'none'});
    });
    $('#minus_cont > .back_btn').on('click',function () {
        $('#minus_cont').stop().animate({right:-600,opacity:0},1000);
        $('#main').stop().animate({left:0},500);
        $('#main > div .bg_box li .more_arrow > img').stop().css({'display':'block'});
        $('#plus_cont').stop().css({'display':'none'}).animate({left:-600,opacity:0});
        $('#main .objs.btns').stop().css({'display':'block'});
        $('#home_close').stop().css({'display':'block'});
        
    });

    $('#minus_cont .goToP').on('click',function () {
        $('#plus_cont').stop().css({'display':'block'}).animate({left:0,opacity:1},800);
        $('#main').stop().animate({left:600},800);
        $('#main > div .bg_box li .more_arrow > img').stop().css({'display':'none'});
        $('#minus_cont').stop().css({'display':'none'});
        $('#main .objs.btns').stop().css({'display':'none'});
        $('#home_close').stop().css({'display':'none'});
        $('#plus_cont .objs.plus_obj li:nth-child(1)').stop().delay(800).animate({marginLeft:-634,top:0,opacity:1},1500,'easeOutBack');
    });


    $('#plus_cont .goToM').on('click',function () {
        $('#minus_cont').stop().css({'display':'block'}).animate({right:0,opacity:1},800);
        $('#main').stop().animate({left:-600},800);
        $('#main > div .bg_box li .more_arrow > img').stop().css({'display':'none'});
        $('#plus_cont').stop().css({'display':'none'});
        $('#main .objs.btns').stop().css({'display':'none'});
        $('#home_close').stop().css({'display':'none'});
    });


    
    
    // scene02 pop
    $('#video_btn').on('click',function () {
        $('#video_pop').fadeIn();
    });

    $('#video_pop').on('click',function () {
        $('#video_pop').fadeOut();
    });

    // scene03 pop
    $('#scene03 .contents .video_btn').on('click',function () {
        $('#scene03 .video2').fadeIn();
    });

    $('.close').on('click',function () {
        $('#scene03 .video2').fadeOut();
    });


    // scene03_1 pop
    $('#scene03_1 .contents2 .video_btn').on('click',function () {
        $('#scene03_1 .video3').fadeIn();
        $('#scene03 .video2').fadeOut();

    });

    $('.close').on('click',function () {
        $('#scene03_1 .video3').fadeOut();
    });



    //scene03
    $('#scene03 .contents .swap_btn').on('mouseenter',function () {
        $(this).stop().animate({top:100},1000);
    });
    $('#scene03 .contents .swap_btn').on('mouseleave',function () {
        $(this).stop().animate({top:140},1000);
    });

    $('#scene03 .contents .swap_btn').on('click',function () {

        $('#scene03_1').stop().animate({marginLeft:-1000},800,'easeOutExpo');

        $('#scene03_1 .contents2 .char').stop().delay(500).animate({marginLeft:-425,opacity:1},500);
        $('#scene03_1 .clock li:nth-child(1)').stop().delay(500).animate({top: 375},1000,'easeOutBack');
        $('#scene03_1 .clock li:nth-child(2)').stop().delay(1200).animate({top: 380},1000,'easeOutBack');
        $('#scene03_1 .clock li:nth-child(3)').stop().delay(800).animate({top: 230},1000,'easeOutBack');
        $('#scene03_1 .clock li:nth-child(4)').stop().delay(1000).animate({top: 300},1000,'easeOutBack');
        $('#scene03_1 .clock li:nth-child(5)').stop().delay(1400).animate({top: 255},1000,'easeOutBack');
        $('#scene03_1 .clock li:nth-child(6)').stop().delay(1800).animate({top: 255},1000,'easeOutBack');

        $('#scene03_1 .contents2 .note').stop().animate({top:625,opacity:1},500);
        $('#scene03_1 .contents2 .note_paper').stop().animate({top:625,opacity:1},500);
        $('#scene03_1 .contents2 .pic').stop().animate({top:852,opacity:1},500);
        $('#scene03_1 .contents2 .return_btn').stop().animate({top:595,opacity:1},500);
        $('#scene03_1 .contents2 .swap_txt').stop().animate({top:650,opacity:1},500);
        $('#scene03_1 .contents2 .video_btn').stop().animate({top:1182,opacity:1},500);

    });





    //scene03
    $('#scene03_1 .contents2 .return_btn').on('mouseenter',function () {
        $(this).stop().animate({top:540},1000);
    });
    $('#scene03_1 .contents2 .return_btn').on('mouseleave',function () {
        $(this).stop().animate({top:580},1000);
    });

    $('#scene03_1 .contents2 .return_btn').on('click',function () {

        $('#scene03_1').stop().animate({marginLeft:1000},800,'easeInExpo');

    });


    // scene04 section

    $('#scene04 .btn li:nth-child(1)').on('click',function () {
       $('#scene04 .btn li:nth-child(1) img').attr('src','img/scene04/btn/btn-film1.png');
       $('#scene04 .btn li:nth-child(2) img').attr('src','img/scene04/btn/btn-defalt.png');
       $('#scene04 .btn li:nth-child(3) img').attr('src','img/scene04/btn/btn-defalt.png');
       $('#scene04 .btn li:nth-child(4) img').attr('src','img/scene04/btn/btn-defalt.png');
       $('#scene04 .btn li:nth-child(5) img').attr('src','img/scene04/btn/dotted-film1.png');

       // film1 appear
       $('#scene04 .film01 .slide').stop().delay(200).animate({marginLeft:-1000,opacity:1},500);
       $('#scene04 .film01 .tit').stop().delay(400).animate({marginLeft:-732,opacity:1},500);
       $('#scene04 .film01 .char').stop().delay(900).animate({marginLeft:-646,opacity:1},500);
       $('#scene04 .film01 .sub > div .left').stop().delay(200).animate({marginLeft: 0,opacity:1},500);
       $('#scene04 .film01 .sub > div .right').stop().delay(200).animate({marginLeft: 295,opacity:1},500);
       $('#scene04 .film01 .sub > div .subtit1').stop().delay(600).fadeIn(1000);
       $('#scene04 .film01 .sub .txt').stop().delay(800).animate({top: 130,opacity:1},700);

        // film2,3,4 disappear
       $('#scene04 .film02 .slide').stop().animate({marginLeft:-1500,opacity:0});
       $('#scene04 .film02 .tit').stop().animate({marginLeft:-1000,opacity:0});
       $('#scene04 .film02 .char').stop().animate({marginLeft:-790,opacity:0});
       $('#scene04 .film02 .sub > div .left').stop().animate({marginLeft: 150,opacity:0});
       $('#scene04 .film02 .sub > div .right').stop().animate({marginLeft: 150,opacity:0});
       $('#scene04 .film02 .sub > div .subtit2').stop().fadeOut();
       $('#scene04 .film02 .sub .txt').stop().animate({top: 100,opacity:0});

       $('#scene04 .film03 .slide').stop().animate({marginLeft:250,opacity:0});
       $('#scene04 .film03 .tit').stop().animate({marginLeft:465,opacity:0});
       $('#scene04 .film03 .char').stop().animate({marginLeft:0,opacity:0});
       $('#scene04 .film03 .sub > div .left').stop().animate({marginLeft: 150,opacity:0});
       $('#scene04 .film03 .sub > div .right').stop().animate({marginLeft: 150,opacity:0});
       $('#scene04 .film03 .sub > div .subtit3').stop().fadeOut();
       $('#scene04 .film03 .sub .txt').stop().animate({top: 100,opacity:0});

       $('#scene04 .film04 .slide').stop().animate({marginLeft:-1500,opacity:0});
       $('#scene04 .film04 .tit').stop().animate({marginLeft:-946,opacity:0});
       $('#scene04 .film04 .char').stop().animate({marginLeft:-733,opacity:0});
       $('#scene04 .film04 .sub > div .left').stop().animate({marginLeft: 150,opacity:0});
       $('#scene04 .film04 .sub > div .right').stop().animate({marginLeft: 150,opacity:0});
       $('#scene04 .film04 .sub > div .subtit4').stop().fadeOut();
       $('#scene04 .film04 .sub .txt').stop().animate({top: 100,opacity:0});



        // scene
        $('#scene04 .film01').css({'z-index':'110'});
        $('#scene04 .film02').css({'z-index':'100'});
        $('#scene04 .film03').css({'z-index':'100'});
        $('#scene04 .film04').css({'z-index':'100'});
        $('#scene04 .film01').stop().animate({marginLeft:0},500,'easeOutExpo');
        $('#scene04 .film02').stop().animate({marginLeft:2000},500,'easeOutExpo');
        $('#scene04 .film03').stop().animate({marginLeft:2000},500,'easeOutExpo');
        $('#scene04 .film04').stop().animate({marginLeft:2000},500,'easeOutExpo');





    });

    $('#scene04 .btn li:nth-child(2)').on('click',function () {

        $('#scene04 .btn li:nth-child(1) img').attr('src','img/scene04/btn/btn-defalt.png');
        $('#scene04 .btn li:nth-child(2) img').attr('src','img/scene04/btn/btn-film2.png');
        $('#scene04 .btn li:nth-child(3) img').attr('src','img/scene04/btn/btn-defalt.png');
        $('#scene04 .btn li:nth-child(4) img').attr('src','img/scene04/btn/btn-defalt.png');
        $('#scene04 .btn li:nth-child(5) img').attr('src','img/scene04/btn/dotted-film2.png');

        // film2 appear

        $('#scene04 .film02 .slide').stop().delay(200).animate({marginLeft:-1000,opacity:1},500);
        $('#scene04 .film02 .tit').stop().delay(400).animate({marginLeft:-727,opacity:1},500);
        $('#scene04 .film02 .char').stop().delay(900).animate({marginLeft:-590,opacity:1},500);
        $('#scene04 .film02 .sub > div .left').stop().delay(200).animate({marginLeft: 0,opacity:1},500);
        $('#scene04 .film02 .sub > div .right').stop().delay(200).animate({marginLeft: 295,opacity:1},500);
        $('#scene04 .film02 .sub > div .subtit2').stop().delay(600).fadeIn(1000);
        $('#scene04 .film02 .sub .txt').stop().delay(800).animate({top: 130,opacity:1},700);

        // film1,3,4 disappear
        $('#scene04 .film01 .slide').stop().animate({marginLeft:-1500,opacity:0});
        $('#scene04 .film01 .tit').stop().animate({marginLeft:-800,opacity:0});
        $('#scene04 .film01 .char').stop().animate({marginLeft:-800,opacity:0});
        $('#scene04 .film01 .sub > div .left').stop().animate({marginLeft: 150,opacity:0});
        $('#scene04 .film01 .sub > div .right').stop().animate({marginLeft: 150,opacity:0});
        $('#scene04 .film01 .sub > div .subtit1').stop().fadeOut();
        $('#scene04 .film01 .sub .txt').stop().animate({top: 100,opacity:0});

        $('#scene04 .film03 .slide').stop().animate({marginLeft:250,opacity:0});
        $('#scene04 .film03 .tit').stop().animate({marginLeft:465,opacity:0});
        $('#scene04 .film03 .char').stop().animate({marginLeft:0,opacity:0});
        $('#scene04 .film03 .sub > div .left').stop().animate({marginLeft: 150,opacity:0});
        $('#scene04 .film03 .sub > div .right').stop().animate({marginLeft: 150,opacity:0});
        $('#scene04 .film03 .sub > div .subtit3').stop().fadeOut();
        $('#scene04 .film03 .sub .txt').stop().animate({top: 100,opacity:0});

        $('#scene04 .film04 .slide').stop().animate({marginLeft:-1500,opacity:0});
        $('#scene04 .film04 .tit').stop().animate({marginLeft:-946,opacity:0});
        $('#scene04 .film04 .char').stop().animate({marginLeft:-733,opacity:0});
        $('#scene04 .film04 .sub > div .left').stop().animate({marginLeft: 150,opacity:0});
        $('#scene04 .film04 .sub > div .right').stop().animate({marginLeft: 150,opacity:0});
        $('#scene04 .film04 .sub > div .subtit4').stop().fadeOut();
        $('#scene04 .film04 .sub .txt').stop().animate({top: 100,opacity:0});






        // scene
        $('#scene04 .film01').css({'z-index':'100'});
        $('#scene04 .film02').css({'z-index':'110'});
        $('#scene04 .film03').css({'z-index':'100'});
        $('#scene04 .film04').css({'z-index':'100'});
        $('#scene04 .film01').stop().animate({marginLeft:2000},500,'easeOutExpo');
        $('#scene04 .film02').stop().animate({marginLeft:0},500,'easeOutExpo');
        $('#scene04 .film03').stop().animate({marginLeft:2000},500,'easeOutExpo');
        $('#scene04 .film04').stop().animate({marginLeft:2000},500,'easeOutExpo');


    });

    $('#scene04 .btn li:nth-child(3)').on('click',function () {
        $('#scene04 .btn li:nth-child(1) img').attr('src','img/scene04/btn/btn-defalt.png');
        $('#scene04 .btn li:nth-child(2) img').attr('src','img/scene04/btn/btn-defalt.png');
        $('#scene04 .btn li:nth-child(3) img').attr('src','img/scene04/btn/btn-film3.png');
        $('#scene04 .btn li:nth-child(4) img').attr('src','img/scene04/btn/btn-defalt.png');
        $('#scene04 .btn li:nth-child(5) img').attr('src','img/scene04/btn/dotted-film3.png');

        // film3 appear
        $('#scene04 .film03 .slide').stop().delay(200).animate({marginLeft:-246,opacity:1},500);
        $('#scene04 .film03 .tit').stop().delay(400).animate({marginLeft:265,opacity:1},500);
        $('#scene04 .film03 .char').stop().delay(900).animate({marginLeft:-199,opacity:1},500);
        $('#scene04 .film03 .sub > div .left').stop().delay(200).animate({marginLeft: 0,opacity:1},500);
        $('#scene04 .film03 .sub > div .right').stop().delay(200).animate({marginLeft: 295,opacity:1},500);
        $('#scene04 .film03 .sub > div .subtit3').stop().delay(600).fadeIn(1000);
        $('#scene04 .film03 .sub .txt').stop().delay(800).animate({top: 130,opacity:1},700);


        // film1,2,4 disappear
        $('#scene04 .film01 .slide').stop().animate({marginLeft:-1500,opacity:0});
        $('#scene04 .film01 .tit').stop().animate({marginLeft:-800,opacity:0});
        $('#scene04 .film01 .char').stop().animate({marginLeft:-800,opacity:0});
        $('#scene04 .film01 .sub > div .left').stop().animate({marginLeft: 150,opacity:0});
        $('#scene04 .film01 .sub > div .right').stop().animate({marginLeft: 150,opacity:0});
        $('#scene04 .film01 .sub > div .subtit1').stop().fadeOut();
        $('#scene04 .film01 .sub .txt').stop().animate({top: 100,opacity:0});

        $('#scene04 .film02 .slide').stop().animate({marginLeft:-1500,opacity:0});
        $('#scene04 .film02 .tit').stop().animate({marginLeft:-1000,opacity:0});
        $('#scene04 .film02 .char').stop().animate({marginLeft:-790,opacity:0});
        $('#scene04 .film02 .sub > div .left').stop().animate({marginLeft: 150,opacity:0});
        $('#scene04 .film02 .sub > div .right').stop().animate({marginLeft: 150,opacity:0});
        $('#scene04 .film02 .sub > div .subtit2').stop().fadeOut();
        $('#scene04 .film02 .sub .txt').stop().animate({top: 100,opacity:0});

        $('#scene04 .film04 .slide').stop().animate({marginLeft:-1500,opacity:0});
        $('#scene04 .film04 .tit').stop().animate({marginLeft:-946,opacity:0});
        $('#scene04 .film04 .char').stop().animate({marginLeft:-733,opacity:0});
        $('#scene04 .film04 .sub > div .left').stop().animate({marginLeft: 150,opacity:0});
        $('#scene04 .film04 .sub > div .right').stop().animate({marginLeft: 150,opacity:0});
        $('#scene04 .film04 .sub > div .subtit4').stop().fadeOut();
        $('#scene04 .film04 .sub .txt').stop().animate({top: 100,opacity:0});



        // scene
        $('#scene04 .film01').css({'z-index':'100'});
        $('#scene04 .film02').css({'z-index':'100'});
        $('#scene04 .film03').css({'z-index':'110'});
        $('#scene04 .film04').css({'z-index':'100'});
        $('#scene04 .film01').stop().animate({marginLeft:2000},500,'easeOutExpo');
        $('#scene04 .film02').stop().animate({marginLeft:2000},500,'easeOutExpo');
        $('#scene04 .film03').stop().animate({marginLeft:0},500,'easeOutExpo');
        $('#scene04 .film04').stop().animate({marginLeft:2000},500,'easeOutExpo');


    });

    $('#scene04 .btn li:nth-child(4)').on('click',function () {
        $('#scene04 .btn li:nth-child(1) img').attr('src','img/scene04/btn/btn-defalt.png');
        $('#scene04 .btn li:nth-child(2) img').attr('src','img/scene04/btn/btn-defalt.png');
        $('#scene04 .btn li:nth-child(3) img').attr('src','img/scene04/btn/btn-defalt.png');
        $('#scene04 .btn li:nth-child(4) img').attr('src','img/scene04/btn/btn-film4.png');
        $('#scene04 .btn li:nth-child(5) img').attr('src','img/scene04/btn/dotted-film4.png');

        // film4 appear
        $('#scene04 .film04 .slide').stop().delay(200).animate({marginLeft:-1000,opacity:1},500);
        $('#scene04 .film04 .tit').stop().delay(400).animate({marginLeft:-746,opacity:1},500);
        $('#scene04 .film04 .char').stop().delay(900).animate({marginLeft:-533,opacity:1},500);
        $('#scene04 .film04 .sub > div .left').stop().delay(200).animate({marginLeft: 0,opacity:1},500);
        $('#scene04 .film04 .sub > div .right').stop().delay(200).animate({marginLeft: 295,opacity:1},500);
        $('#scene04 .film04 .sub > div .subtit4').stop().delay(600).fadeIn(1000);
        $('#scene04 .film04 .sub .txt').stop().delay(800).animate({top: 130,opacity:1},700);


        //film1,2,3 disappear

        $('#scene04 .film01 .slide').stop().animate({marginLeft:-1500,opacity:0});
        $('#scene04 .film01 .tit').stop().animate({marginLeft:-800,opacity:0});
        $('#scene04 .film01 .char').stop().animate({marginLeft:-800,opacity:0});
        $('#scene04 .film01 .sub > div .left').stop().animate({marginLeft: 150,opacity:0});
        $('#scene04 .film01 .sub > div .right').stop().animate({marginLeft: 150,opacity:0});
        $('#scene04 .film01 .sub > div .subtit1').stop().fadeOut();
        $('#scene04 .film01 .sub .txt').stop().animate({top: 100,opacity:0});

        $('#scene04 .film02 .slide').stop().animate({marginLeft:-1500,opacity:0});
        $('#scene04 .film02 .tit').stop().animate({marginLeft:-1000,opacity:0});
        $('#scene04 .film02 .char').stop().animate({marginLeft:-790,opacity:0});
        $('#scene04 .film02 .sub > div .left').stop().animate({marginLeft: 150,opacity:0});
        $('#scene04 .film02 .sub > div .right').stop().animate({marginLeft: 150,opacity:0});
        $('#scene04 .film02 .sub > div .subtit2').stop().fadeOut();
        $('#scene04 .film02 .sub .txt').stop().animate({top: 100,opacity:0});

        $('#scene04 .film03 .slide').stop().animate({marginLeft:250,opacity:0});
        $('#scene04 .film03 .tit').stop().animate({marginLeft:465,opacity:0});
        $('#scene04 .film03 .char').stop().animate({marginLeft:0,opacity:0});
        $('#scene04 .film03 .sub > div .left').stop().animate({marginLeft: 150,opacity:0});
        $('#scene04 .film03 .sub > div .right').stop().animate({marginLeft: 150,opacity:0});
        $('#scene04 .film03 .sub > div .subtit3').stop().fadeOut();
        $('#scene04 .film03 .sub .txt').stop().animate({top: 100,opacity:0});



        // scene
        $('#scene04 .film01').css({'z-index':'100'});
        $('#scene04 .film02').css({'z-index':'100'});
        $('#scene04 .film03').css({'z-index':'100'});
        $('#scene04 .film04').css({'z-index':'110'});
        $('#scene04 .film01').stop().animate({marginLeft:2000},500,'easeOutExpo');
        $('#scene04 .film02').stop().animate({marginLeft:2000},500,'easeOutExpo');
        $('#scene04 .film03').stop().animate({marginLeft:2000},500,'easeOutExpo');
        $('#scene04 .film04').stop().animate({marginLeft:0},500,'easeOutExpo');


    });


    // scene5

    $('#scene05 .event .topbtn > img:nth-child(2)').on('click',function () {
        $('#scene05 .event .movie').fadeIn();
    });

    $('#scene05 .event .topbtn > img:nth-child(1)').on('click',function () {
        $('#scene05 .event .movie').fadeOut();
    });






});


$(function () {




    // 메뉴부분
    $('.navJs > li > a').click(function () {
        var posY = $($(this).attr('href')).position().top;
        $('#wrap').stop().animate({'scrollTop': posY}, 1200, 'easeInOutExpo');
        return false;
    });


    //스크롤 이벤트 영역
    $(window).scroll(function () {
        var scrollTop = $(document).scrollTop();
        $('.posNum').text(scrollTop); // 스크롤값


        //---------- 스크롤과 함께 이벤트가 발생하는 부분--------------



        if ( scrollTop >= 1220) {
            $('#scene02 .contents .char').stop().delay(200).animate({marginLeft:100,opacity:1},500);
            $('#scene02 .contents .note').stop().animate({top:187,opacity:1},500);
            $('#scene02 .contents .pics').stop().animate({top:100,opacity:1},500);
            $('#scene02 .contents .cuffs').stop().animate({top:541,opacity:1},500);

        }

        if ( scrollTop >= 2610) {
            $('#scene03 .contents .char').stop().delay(200).animate({marginLeft:-742,opacity:1},500);
            $('#scene03 .contents .note').stop().animate({top:170,opacity:1},500);
            $('#scene03 .contents .note_paper').stop().animate({top:177,opacity:1},500);
            $('#scene03 .contents .pic').stop().animate({top:345,opacity:1},500);
            $('#scene03 .contents .swap_btn').stop().animate({top:140,opacity:1},500);
            $('#scene03 .contents .swap_txt').stop().animate({top:195,opacity:1},500);
            $('#scene03 .contents .video_btn').stop().animate({top:727,opacity:1},500);
        }

        if ( scrollTop >= 3910) {
            $('#scene04 .film01 .slide').stop().delay(200).animate({marginLeft:-1000,opacity:1},500);
            $('#scene04 .film01 .tit').stop().delay(400).animate({marginLeft:-732,opacity:1},500);
            $('#scene04 .film01 .char').stop().delay(900).animate({marginLeft:-646,opacity:1},500);
            $('#scene04 .film01 .sub > div .left').stop().delay(200).animate({marginLeft: 0,opacity:1},500);
            $('#scene04 .film01 .sub > div .right').stop().delay(200).animate({marginLeft: 295,opacity:1},500);
            $('#scene04 .film01 .sub > div .subtit1').stop().delay(600).fadeIn(1000);
            $('#scene04 .film01 .sub .txt').stop().delay(800).animate({top: 130,opacity:1},700);        }

        if ( scrollTop >= 5210) {
            $('#scene05 .event .char1').stop().animate({marginLeft:-792,opacity:1},500);
            $('#scene05 .event .char2').stop().animate({marginLeft:159,opacity:1},500);
        }








        // 메뉴 활성화
        $('#wrap > div').each(function (i) {
            var fastNum = 100; // 메뉴를 빨리 활성화 시키는 값
            var firstY = $('#wrap > div:first').position().top;
            var posY = $(this).position().top;
            if (scrollTop <= firstY - fastNum) {
                $('.navJs').each(function () {
                    $('li', this).removeClass('on').eq(0).addClass('on');
                })
            } else if (scrollTop >= posY - fastNum) {
                $('.navJs').each(function () {
                    $('li', this).removeClass('on').eq(i).addClass('on');
                })
            }
        });

    });

});