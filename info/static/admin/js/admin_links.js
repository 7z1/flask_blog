function getCookie(name) {
    var r = document.cookie.match("\\b" + name + "=([^;]*)\\b");
    return r ? r[1] : undefined;
}

$(function(){
    var $a = $('.edit');
    var $add = $('.addtype');
    var $pop = $('.pop_con');
    var $cancel = $('.cancel');
    var $confirm = $('.confirm');
    var $error = $('.error_tip');
    var $input = $('.input_txt3');
    var $input2 = $('.input_txt4');
    var sHandler = 'edit';
    var sId = 0;
    var $del = $('.delete');

    $del.click(function() {
        var params = {}

        var sId = $(this).attr('data-type_id');

        params = {
            "id": sId,
        };

        // 发起删除分类请求
        $.ajax({
            url:"/admin/news_type_del",
            method: "post",
            headers: {
                "X-CSRFToken": getCookie("csrftoken")
            },
            data: JSON.stringify(params),
            contentType: "application/json",
            success: function (resp) {
                if (resp.errno == "0") {
                    // 刷新当前界面
                    location.reload();
                }else {
                    $error.html(resp.errmsg).show();
                }
            }
        })
    })



    $a.click(function(){
        sHandler = 'edit';
        sId = $(this).parent().siblings().eq(0).html();
        $pop.find('h3').html('修改链接');
        $pop.find('.input_txt3').val($(this).parent().prev().prev().html());
        $pop.find('.input_txt4').val($(this).parent().prev().html());
        $pop.show();
    });

    $add.click(function(){
        sHandler = 'add';
        $pop.find('h3').html('新增链接');
        $input.val('');
        $input2.val('');
        $pop.show();
    });

    $cancel.click(function(){
        $pop.hide();
        $error.hide();
    });

    $input.click(function(){
        $error.hide();
    });

    $confirm.click(function(){

        var params = {}
        if(sHandler=='edit')
        {
            var sVal = $input.val();
            var sUrl = $input2.val();
            if(sVal=='' || sUrl=='')
            {
                $error.html('输入框不能为空').show();
                return;
            }
            params = {
                "id": sId,
                "name": sVal,
                "url": sUrl,
            };
        }
        else
        {
            var sVal = $input.val();
            var sUrl = $input2.val();
            if(sVal=='' || sUrl=='')
            {
                $error.html('输入框不能为空').show();
                return;
            }
            params = {
                "name": sVal,
                "url": sUrl,
            }
        }

        // 发起修改分类请求
        $.ajax({
            url:"/admin/admin_links",
            method: "post",
            headers: {
                "X-CSRFToken": getCookie("csrftoken")
            },
            data: JSON.stringify(params),
            contentType: "application/json",
            success: function (resp) {
                if (resp.errno == "0") {
                    // 刷新当前界面
                    location.reload();
                }else {
                    $error.html(resp.errmsg).show();
                }
            }
        })

    })
})