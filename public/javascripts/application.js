// Put your application scripts here
var Player = function (clicks, slider) {
    this.current_slide = 0;

    this.player = $("#audio-player").get(0);
    this.currentTime = 0;
    this.pauseTime = 0;

    var paused = false;
    this.timeouts = [];
    var original_clicks = clicks;
    var slide_clicks = clicks;
    var external_slider = slider;

    Player.prototype.play = function () {
        switcher = function (number, index, parent) {
            return function () {
                parent.current_slide = index;
                parent.currentTime = (new Date).getTime();
                parent.setSlide(number);

                if (index == slide_clicks.length - 1) {
                    parent.current_slide = 0;
                }

            }
        };
        var overall_delta;
        for (var i = this.current_slide; i < slide_clicks.length; i++) {
            if (this.pauseTime > 0) {
                var delta = 0;
                for (var k = 0; k < this.current_slide; k++) {
                    delta = delta + slide_clicks[k][1];
                }
                if (i == this.current_slide) {
                    overall_delta = this.pauseTime - this.currentTime + delta;
                    this.timeouts[i] = setTimeout(switcher(slide_clicks[i][0], i, this), slide_clicks[i][1] - overall_delta);
                }
                else {
                    overall_delta = this.pauseTime - this.currentTime + delta;
                    this.timeouts[i] = setTimeout(switcher(slide_clicks[i][0], i, this), slide_clicks[i][1] - overall_delta);
                }


            }
            else
                this.timeouts[i] = setTimeout(switcher(slide_clicks[i][0], i, this), slide_clicks[i][1]);

        }
        this.setSlide(slide_clicks[this.current_slide][0]);

        this.player.play();
        this.pauseTime = 0;
    };

    Player.prototype.stop = function () {
        this.pause();
        this.current_slide = 0;
        this.setSlide(slide_clicks[0][0]);
        this.player.pause();
        this.player.currentTime = 0;
        this.pauseTime = 0;
        this.currentTime = 0;
    };

    Player.prototype.setSlide = function (number) {
        external_slider.set(number, this);
    };

};

var Slider = function () {
    Slider.prototype.set = function (index, player) {
        if (index > 0) {
            $('#slide').html("");
            album_images[index - 1].appendTo($('#slide'));
            $("#indicator").html(index + "/" + album_images.length);
        } else if (index == 0 || index == -1) {
            $('#slide').html("");
            album_images[0].appendTo($('#slide'));

            $("#indicator").html(1 + "/" + album_images.length);
        }

    }
};