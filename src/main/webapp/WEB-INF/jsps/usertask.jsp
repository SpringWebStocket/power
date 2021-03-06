<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/5/12/012
  Time: 10:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<%@include file="header.jsp" %>
<div class="tpl-content-wrapper">
    <div class="row-content am-cf">
        <table id="test" lay-filter="test"></table>
        <script type="text/html" id="barDemo">
            <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">提交任务</a>
            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">取消任务</a>
        </script>
    </div>
</div>
</body>
<div id="qq">
    <form class="layui-form layui-form-pane1" id="submitUserTask" name="submitUserTask">
        <br>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 86px;">设备编号</label>
            <div class="layui-input-block">
                <input style="width: 250px;" type="text" name="equipmentNumber" id="number" lay-verify="required|number"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
            <input type="hidden" id="wavSrc" name="wavSrc" >
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label" style="width: 86px;">附加信息</label>
            <div class="layui-input-block">
                <textarea placeholder="填写一些设备的其他情况" style="width: 300px;" id="problem" name="checkProblem" class="layui-textarea"></textarea>
            </div>
        </div>
        <div class="layui-form-item" style="position: absolute;left: 110px;">
            <div class="layui-input-block">
                <button  class="layui-btn" lay-submit lay-filter="*">开始上传</button>
            </div>
        </div>
    </form>
    <div style="position: absolute;left: 110px;">
        <div class="layui-upload">
            <button type="button" class="layui-btn layui-btn-normal" id="selectFile">上传文件</button>
        </div>
    </div>

</div>


<script>
    layui.use(['upload','form'], function () {
        var $ = layui.jquery,
            upload = layui.upload,
            form =layui.form;
        var ww;
        upload.render({
            elem: '#selectFile'
            , url: '<%=request.getContextPath()%>/uploadFile'
            , accept: 'file'
            // , auto: false
            // , bindAction: '#startUploadFile'
            ,size: 1024 * 400,

            done: function (res) {
                if (res.code > 0) {
                    alert("code"+res.code);
                    alert("路径"+res.src);
                    console.log("123");
                    console.log($("#wavSrc"));
                    console.log(res.src);
                    console.log("123");
                    var ww = $('#wavSrc').attr("value",res.src);
                    alert("www"+ww);
                    layer.msg("文件保存成功");
                    //document.getElementById("wavSrc").value = res.date.url;
                } else if (res.code < 0) {
                    layer.msg('文件格式不正确');
                } else {
                    layer.msg("文件上传错误");
                }
            }
            });

        //提交任务信息
        form.on(('submit(*)'),function (message){
            $.ajax({
                url:'<%=request.getContextPath()%>/submitTask1',
                type:'post',
                contentType:'application/json; charset=utf-8',
                data:JSON.stringify({
                    number:message.field.equipmentNumber,
                    wavSrc:message.field.wavSrc,
                    problem:message.field.checkProblem,
                }),
                success:function (res) {
                    if (res == "1"){
                        setTimeout(function () {
                            location.reload();
                        },1000)
                        layer.msg("任务提交成功");
                    }else{
                        layer.msg("任务提交失败");
                    }
                }

            });
            return false;
        });

    });


    layui.use(['layer', 'table', 'element', 'form'], function () {
        var layer = layui.layer
            , form = layui.form
            , table = layui.table;

        //渲染
        table.render({
            elem: '#test'  //绑定table表格
            , height: 600
            , url: '<%=request.getContextPath()%>/usertasklist' //后台springmvc接收路径
            , page: true    //true表示分页
            /* page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
             layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
                 //,curr: 5 //设定初始在第 5 页
                 ,groups: 3 //只显示 1 个连续页码
                 ,first: true //不显示首页
                 ,last: true //不显示尾页
              }*/
//            ,where:{rows:limit} //传参数
            , limit: 10
            , id: 'contenttable'
            , toolbar: '#toolbarDemo'
            , cols: [[
                {field: 'equipmentNumber', title: '设备编号', align: 'center', width: 246, fixed: 'left', sort: true}
                , {field: 'equipmentName', title: '设备名称', align: 'center', width: 210, fixed: 'left'}
                , {field: 'taskAcceptDate', title: '接收日期', align: 'center', width: 341}
                , {fixed: 'right', width: 266, title: '操作', align: 'center', toolbar: '#barDemo'}
            ]]
        });


        //监听表格行点击
        table.on('tr', function (obj) {
            console.log(obj)
        });

        //监听表格复选框选择
        table.on('checkbox(test)', function (obj) {
            console.log(obj)
        });

        //监听表格单选框选择
        table.on('radio(test2)', function (obj) {
            console.log(obj)
        });

        //监听单元格编辑
        table.on('edit(test2)', function (obj) {
            var value = obj.value //得到修改后的值
                , data = obj.data //得到所在行所有键值
                , field = obj.field; //得到字段

        });

        //监听工具条
        table.on('tool(test)', function (obj) {
            var data = obj.data;
            if (obj.event === 'del') {
                layer.confirm('真的要取消任务么?', {offset: "100px"}, function (index) {
                    console.log("really?:" + obj);
                    console.log("data" + data.equipmentNumber);
                    $.ajax({
                        url: "<%=request.getContextPath()%>/deleteusertask",
                        type: "POST",
                        data: {"equipmentNumber": data.equipmentNumber},
                        dataType: "json",
                        success: function (data) {
                            if (data == null) {
                                layer.msg("删除失败", {icon: 5});
                            } else {
                                //删除这一行
                                obj.del();
                                //关闭弹框
                                layer.close(index);
                                layer.msg("删除成功", {icon: 6});
                                layer.closeAll();
                                parent.location.reload();
                                Load(); //删除完需要加载数据
                            }
                        },
                        error: function (data) {
                            alert(data);
                        },
                    });
                });
            } else if (obj.event === 'detail') {
                layer.open({
                    title: '提交任务',
                    type: 1,
                    offset: "20px",
                    area: ['530px', '500px'],
                    content: $("#qq")
                });
                var a = $("#number").val(data.equipmentNumber);
                form.render();
            }
        });
    });
</script>
</html>
