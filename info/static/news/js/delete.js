/**
 * Created by 7z1 on 2018/9/3.
 */

function getCookie(name) {
    var r = document.cookie.match("\\b" + name + "=([^;]*)\\b");
    return r ? r[1] : undefined;
}

$(function() {
    $('.delete_news').click(function(){
        var news_id = $(this).attr('data-newid')
        var params = {
            'news_id': news_id
        }
        $.ajax({
            url: '/user/news_delete',
            type: 'POST',
            contentType: 'application/json',
            headers: {
                "X-CSRFToken": getCookie("csrftoken")
            },
            data: JSON.stringify(params),
            success: function (resp) {
                if (resp.errno == '0'){
                    // 删除成功
                    window.location.reload()
                }else if (resp.errno == '4101'){
                    $('.login_form_con').show();
                }else{
                    alert(resp.errmsg);
                }
            }
        })
    })
})