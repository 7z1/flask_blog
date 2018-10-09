function getCookie(name) {
    var r = document.cookie.match("\\b" + name + "=([^;]*)\\b");
    return r ? r[1] : undefined;
}

$(function() {

    $('.common_table').delegate('a', 'click', function () {

        var sHandler = $(this).prop('class');

        if (sHandler.indexOf('edit') >= 0) {
            var $this = $(this);
            var action = "add"
            if (sHandler.indexOf('editok') >= 0) {
                // 如果当前该文章已经是推荐状态，再次点击会进行到此代码块内，代表要取消推荐
                action = "remove"
            }

            var news_id = $(this).attr("data-newsid")
            var action_type = $(this).attr("action-type")
            var params = {
                "action_type": action_type,
                "action": action,
                "news_id": news_id
            }

            $.ajax({
                url: "/admin/change_action",
                type: "post",
                contentType: "application/json",
                headers: {
                    "X-CSRFToken": getCookie("csrftoken")
                },
                data: JSON.stringify(params),
                success: function (resp) {
                    if (resp.errno == "0") {

                        // 更新按钮图标
                        if (action == "add") {
                            // 代表是推荐
                            $this.addClass('editok')
                            location.reload()
                        } else {
                            $this.removeClass('editok')
                            location.reload()
                        }
                        // // 更新点赞数据
                        // $this.attr('data-likecount', like_count)
                        // if (like_count == 0) {
                        //     $this.html('赞')
                        // }else {
                        //     // alert($this.html())
                        //     // $this.next().html(like_count)
                        //     $this.html(like_count)
                        // }
                    } else {
                        alert(resp.errmsg)
                    }
                }
            })
        }
    })
})