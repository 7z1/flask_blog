function getCookie(name) {
    var r = document.cookie.match("\\b" + name + "=([^;]*)\\b");
    return r ? r[1] : undefined;
}

$(function(){
    $(".news_edit").submit(function (e) {
        e.preventDefault()
        // 新闻编辑提交

        $(this).ajaxSubmit({
            beforeSubmit: function (request) {
                // 在提交之前，对参数进行处理
                for(var i=0; i<request.length; i++) {
                    var item = request[i]
                    if (item["name"] == "content") {
                        item["value"] =CKEDITOR.instances.content.getData();
                    }
                }
            },
            url: "/admin/add_news",
            type: "POST",
            headers: {
                "X-CSRFToken": getCookie('csrftoken')
            },
            success: function (resp) {
                if (resp.errno == "0") {
                    // 返回上一页，刷新数据
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