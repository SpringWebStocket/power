<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/5/4/004
  Time: 9:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<%@include file="header.jsp"%>
<div class="tpl-content-wrapper">
    <div class="row-content am-cf">
        <table id="test" lay-filter="test"></table>
        <script type="text/html" id="barDemo">
            <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
            <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
        </script>
    </div>
</div>

<%--设备信息弹窗--%>
<form class="layui-form layui-form-pane1" id="form1" name="form1" style="" action="<%=request.getContextPath()%>/modify"  method="post" lay-filter="first1">
    <br>
    <div class="layui-form-item">
        <label class="layui-form-label">设备编号</label>
        <div class="layui-input-inline">
            <input  type="text" name="equipmentNumber" id="number" lay-verify="required|number" autocomplete="off" class="layui-input" readonly>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">设备名称</label>
        <div class="layui-input-inline">
            <input type="text" name="equipmentName" id="name" lay-verify="required|name" autocomplete="off" class="layui-input" readonly>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">设备总数</label>
        <div class="layui-input-inline">
            <input type="text" name="equipmentCount" id="count" lay-verify="required|number" lay-verType="tips" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit lay-filter="*">修改</button>
        </div>
    </div>
</form>
</body>
<script>
    layui.use(['layer', 'table', 'element', 'form'], function() {
        var layer = layui.layer
            , form = layui.form
            , table = layui.table;

        //渲染
        table.render({
            elem: '#test'  //绑定table表格
            , height: 600
            , url: '<%=request.getContextPath()%>/equipmentlists' //后台springmvc接收路径
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
                {field: 'equipmentNumber', title: '设备编号', align: 'center', width: 160, fixed: 'left', sort: true}
                , {field: 'equipmentName', title: '设备名称', align: 'center', width: 135, edit: 'text'}
                , {field: 'equipmentState', title: '设备状态', align: 'center', width: 100}
                , {field: 'equipmentInDate', title: '设备入库时间', align: 'center', width: 150}
                , {field: 'equipmentAmount', title: '设备总数', align: 'center', width: 116, sort: true}
                , {field: 'equipmentVoltage', title: '设备电压', align: 'center', width: 90}
                , {field: 'equipmentI', title: '设备电流', align: 'center', width: 90}
                , {fixed: 'right', width: 220, title: '操作', align: 'center', toolbar: '#barDemo'}
            ]]
        });

        //监听表格行点击
        table.on('tr', function(obj){
            console.log(obj)
        });

        //监听表格复选框选择ss
        table.on('checkbox(test)', function(obj){
            console.log(obj)
        });

        //监听表格单选框选择
        table.on('radio(test2)', function(obj){
            console.log(obj)
        });

        //监听单元格编辑
        table.on('edit(test2)', function(obj){
            var value = obj.value //得到修改后的值
                ,data = obj.data //得到所在行所有键值
                ,field = obj.field; //得到字段

        });

        //监听工具条
        table.on('tool(test)', function(obj){
            var data = obj.data;
            if(obj.event === 'del'){
                layer.confirm('真的删除行么',{offset:"100px"}, function(index){
                    console.log("really?:"+obj);
console.log("data"+data.equipmentNumber);
                    $.ajax({
                        url: "<%=request.getContextPath()%>/equipmentdelete",
                        type: "POST",
                        data:{"equipmentNumber":data.equipmentNumber},
                        dataType: "json",
                        success: function(data){
                            if (data == null){
                                layer.msg("删除失败", {icon: 5});
                            }else{
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
                        error:function (data) {
                            alert(data);
                        },
                    });
                });
            } else if(obj.event === 'edit'){
                layer.open({
                    title:'修改设备信息',
                    type:1,
                    offset:"100px",
                    area:['400px','555px'],
                    content:$("#form1")
                });
                $("#number").val(data.equipmentNumber);
                $("#name").val(data.equipmentName);
                $("#count").val(data.equipmentCount);
                form.render();
                form.on("submit(*)",function (message) {
                    $.ajax({
                        url:'<%=request.getContextPath()%>/equipmentmodify',
                        method:'POST',
                        contentType:'application/json; charset=utf-8',
                        data:JSON.stringify({
                            number:message.field.equipmentNumber,
                            count:message.field.equipmentCount
                        }),
                        success:function (returnCode) {

                            if(returnCode == '1'){
                                layer.closeAll("loading");
                                layer.load(2);
                                layer.msg("修改成功", {icon: 6});

                                setTimeout(function () {
                                    obj.update({
                                        count:data.equipmentCount
                                    });//修改成功修改表格数据不进行跳转
                                    location.reload();//刷新页面
                                    /* layer.closeAll();//关闭所有的弹出层*/
                                },1000);
                                //form.render();
                            }else {
                                layer.msg("修改失败", {icon: 5});
                            }
                        }
                    })
                    return false;//阻止表单跳转  true：表单跳转
                });
            }
        });
    });
</script>
</html>
