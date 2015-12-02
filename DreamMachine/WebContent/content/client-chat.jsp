<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Chat</title>
</head>

<script type="text/javascript"
	src="http://localhost:8123/faye/client.js">
    </script>
<script>

	<%
	/* whenever we return home, there are a handful of things to do 
		1.) write all the friends to the chat panel 
		2.) write all pending friend requests to the request panel
		2.) search the database for any chats received while offline 
	*/

	/* global variables */
	String name = (String) request.getSession().getAttribute("username");
	java.util.ArrayList<String> friends = new java.util.ArrayList<String>();
				
	/* set up friend chats */
	java.util.ArrayList<Integer> friend_ids = 
		(java.util.ArrayList<Integer>) request.getSession().getAttribute("friends");
	assignment.User user;
	if(friend_ids != null) {
		for(int friend_id : friend_ids) {
			user = assignment.User.searchById(friend_id).get(0);
			friends.add(user.username);
			%>register_chat('<%=user.username%>');<%
		}
	}%>
		
	var cur_chat = null;

	/* set up faye subscriptions for messages and friend/challenge requests*/
	var client = new Faye.Client('http://localhost:8123/faye', {timeout: 20});
	<%String uname = "/" + (String) request.getSession().getAttribute("username");%>
	
	/* chat subscription */	
	client.subscribe('<%=uname%>', function(message) {
		var sender = message.substring(0,message.indexOf(' ')-1);

		/* add the message to the chat box */
		var id = sender+'popup-messages';
		display_message(id, message, 'black');
			
		/* add the message to the session cache */	
		/* parse the message */
		if(sender != cur_chat)
			update_sidebar_entry_by_name(sender, "red", "bold");
	});
	
	/* friend request subscription */
	client.subscribe('<%=uname%>'+ '/' + 'requests', function(message) {
		var sender = message.substring(0,message.indexOf(' ')-1);
		
		/* check it's not contained */
		
		/* add friend request to panel */
		var requests = document.getElementById('<%=uname%>'+'-friend-requests');
		var new_request = '<div class="friend-requests">' +
			'<div class="sidebar-name">' +
				'<a id="friend-response-link" class="response-link" \
				href=" /DreamMachine/friendResponse/'+sender+'">'+
					'<span>' + sender + '</span>' +
				'</a>' +
			'</div>' +
		'</div>'
		
		requests.innerHTML = requests.innerHTML + new_request;
		
		/* add to request list using ajax*/
		
	});
	
  	function open_chat(friend) {
  		/* close existing chat */
  		if(cur_chat) close_chat();
  			
  		/* in case there are pending messages, write them out 
  			and then remove them */
  		update_sidebar_entry_by_name(friend, "black", "normal");
  			
  		/* assign new current chat */
  		cur_chat = friend;
  		var elem = document.getElementById(cur_chat+'container');
  		elem.style.display = "block";
  	};
  		
  	function close_chat() {
  		/* close current chat popup */
  		var element = document.getElementById(cur_chat+'container');
  		element.style.display = "none";
  		cur_chat = null;
  	};
  		
  	function register_chat(friend) {
		var element = '<div class="box-container" id="'+friend+'container'+'">';
  		element = element + '<div class="popup-box chat-popup" id="'+ friend +'">';
  		element = element + '<div class="popup-head">';
  		element = element + '<div class="popup-head-left">'+ friend +'</div>';
  		element = element + 
  			'<div class="popup-head-right"><a href="javascript:close_chat();">&#10005;</a></div>';
  		element = element + 
  			'<div style="clear: both"></div></div><div class="popup-messages" id="'+
  			friend+'popup-messages'+'"></div></div>';
  		
  		/* add the chat bar with text area and form */
  		var text_area = '<div class="textarea" id="'+friend+'textarea'+'"> \
  			<textarea name="styled-textarea" id="styled"></textarea></div>';
  		var send_button = '<div class="send-button"> \
  			<a href="javascript:send_chat(\''+friend+'\');">-></a></div>';
  	 	element = element + '<div class="chat-bar">'+
  	 		text_area + 
  	 		send_button +
  	 	'</div>';
  	 		
  		document.getElementsByTagName("body")[0].innerHTML = 
  			document.getElementsByTagName("body")[0].innerHTML + element; 
	}
	
	
		
	function send_chat(friend) {
		/* get the message from the chat box of the current user*/
		var message = document.getElementById(friend+'textarea').lastChild.value;
			
		/* put the message in the chat box */
		message = '<%=name%>' + ': '+ message;
		var id = friend+'popup-messages';
		display_message(id, message, '#9266BD');

		/* send the message */
		client.publish("/" + friend, message);
			
		/* set the chatbox to empty */
		document.getElementById(friend+'textarea').lastChild.value = "";
	}

	function display_message(id, message, color) {
		var chat = document.getElementById(id);
		var len = message.length;
		chat.innerHTML = chat.innerHTML + '<p style="color:'+color+'">';
		while (len - 35 > 0) {
			var partition = message.substring(0, 35);
			chat.innerHTML = chat.innerHTML + message + '</br>';
			len = len - 35;
			message = message.substring(35);
		}
		chat.innerHTML = chat.innerHTML + message + '</p>';
	}

	function update_sidebar_entry_by_name(name, color, weight) {
		var slidebar_names = document.getElementsByClassName("sidebar-name");
		for ( var idx in slidebar_names) {
			var s = slidebar_names[idx].getElementsByTagName("span")[0].innerHTML;
			if (s === name) {
				var a = slidebar_names[idx].getElementsByTagName("a")[0];
				a.style.color = color;
				a.style.fontWeight = weight;
				break;
			}
		}
	}
</script>

<div class="sidebar-container">
	<div class="friend-requests" id="<%=uname%>-friend-requests"></div>
	<div class="chat-sidebar">
		<%for(String friend : friends) {%>
		<div class="sidebar-name">
			<a href="javascript:open_chat('<%=friend%>')"> <span><%=friend%></span></a>
		</div>
		<%}%>
	</div>
</div>

<body>
</body>
</html>