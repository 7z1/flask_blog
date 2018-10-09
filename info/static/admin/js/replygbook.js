function getCookie(name) {
    var r = document.cookie.match("\\b" + name + "=([^;]*)\\b");
    return r ? r[1] : undefined;
}

$(function(){
    var $a = $('.edit');
    var $pop = $('.pop_con');
    var $cancel = $('.cancel');
    var $confirm = $('.confirm');
    var $error = $('.error_tip');
    var $input = $('.input_txt3');
    var sHandler = 'edit';
    var sId = 0;

    $a.click(function(){
        sHandler = 'edit';
        sId = $(this).attr('data-id');
        $pop.find('h3').html('回复留言');
        $pop.find('.input_txt3').val();
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
            if(sVal=='')
            {
                $error.html('输入框不能为空').show();
                return;
            }
            params = {
                "id": sId,
                "content": sVal,
            };
        }

        // 发起回复请求
        $.ajax({
            url:"/admin/gbook_reply",
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