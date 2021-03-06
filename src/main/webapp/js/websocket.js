var websocket;
// var host = document.location.host;
var userId = $("#userId").val(); // 获得当前登录人员的userName
var cnName=$("#cnName").val();
// alert(username)
//判断当前浏览器是否支持WebSocket
if ('WebSocket' in window) {
    // alert("浏览器支持Websocket")
    if(websocket ==null){
//以下用的是ip路径，那么在本地启动项目时也需要使用ip地址进行访问
        websocket = new WebSocket("ws://localhost:8080/webSocket/"+userId+"/"+cnName);
    }
} else {
    alert('当前浏览器 Not support websocket')
}
//连接发生错误的回调方法
websocket.onerror = function() {
    // setMessageInnerHTML("WebSocket连接发生错误");
};
//连接成功建立的回调方法
websocket.onopen = function() {
    // alert("WebSocket连接成功")
    // setMessageInnerHTML("WebSocket连接成功");
}
//接收到消息的回调方法
websocket.onmessage = function(event) {
    // alert("接收到消息的回调方法")
    $('.tanchuang').css('display','block')
    // alert("这是后台推送的消息："+event.data);
    $("#messages").append(event.data  + '<br/>')  ;
    // websocket.close();
    // alert("webSocket已关闭！")
}
//连接关闭的回调方法
websocket.onclose = function() {
    // setMessageInnerHTML("WebSocket连接关闭");
}

//监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
/*window.onbeforeunload = function() {
    closeWebSocket();
}*/
//关闭WebSocket连接
function closeWebSocket() {
    websocket.close();
}
//将消息显示在网页上
function setMessageInnerHTML(innerHTML) {
    document.getElementById('messages').innerHTML += innerHTML + '<br/>';
}