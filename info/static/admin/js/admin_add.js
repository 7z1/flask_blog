function getCookie(name) {
    var r = document.cookie.match("\\b" + name + "=([^;]*)\\b");
    return r ? r[1] : undefined;
}

$(function(){
    $(".news_edit").submit(function (e) {
        e.preventDefault()
        // 新闻编辑提交

        $(this).ajaxSubmit({
            url: "/admin/admin_add",
            type: "POST",
            headers: {
                "X-CSRFToken": getCookie('csrftoken')
            },
            success: function (resp) {
                if (resp.errno == "0") {
                    // 返回上一页，刷新数据
                    alert(resp.errmsg);
                    history.go(-1)
                    location.reload()
                } else {
                    alert(resp.errmsg);
                }
            }
        })
    })
})

// 点击取消，返回上一页
function cancel() {
    history.go(-1)
}