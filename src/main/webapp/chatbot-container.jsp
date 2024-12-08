<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chatbot</title>
    <link rel="stylesheet" href="style.css">
    <style>
        /* Chatbot Styles */
        .chatbot-container {
            position: fixed;
            bottom: 20px;
            right: 20px;
            width: 300px;
            background-color: white;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            display: none; /* Initially hidden */
            flex-direction: column;
            max-height: 400px;
        }

        .chatbot-header {
            background-color: #001a57;
            color: white;
            padding: 10px;
            border-radius: 10px 10px 0 0;
            text-align: center;
            font-weight: bold;
        }

        .chatbot-body {
            padding: 10px;
            flex: 1;
            overflow-y: auto;
        }

        .chatbot-footer {
            padding: 10px;
            border-top: 1px solid #ddd;
            display: flex;
            justify-content: space-between;
        }

        .chatbot-input {
            width: 80%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 20px;
        }

        .chatbot-send {
            background-color: #001a57;
            color: white;
            padding: 8px 12px;
            border: none;
            border-radius: 20px;
            cursor: pointer;
        }

        .chatbot-message {
            margin: 10px 0;
            padding: 10px;
            border-radius: 10px;
            max-width: 80%;
            word-wrap: break-word;
        }

        .user-message {
            background-color: #f1f1f1;
            align-self: flex-end;
        }

        .bot-message {
            background-color: #e6e6e6;
            align-self: flex-start;
        }

        /* Chatbot button to open chat */
        .chatbot-button {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #001a57;
            color: white;
            border: none;
            border-radius: 50%;
            padding: 15px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <!-- Chatbot button to open chat -->
    <button class="chatbot-button" onclick="toggleChatbot()">Ask UVaChat</button>

    <!-- Chatbot container -->
    <div class="chatbot-container" id="chatbot">
        <div class="chatbot-header">
            Ask UVaChat
        </div>
        <div class="chatbot-body" id="chatbotBody">
            <div class="chatbot-message bot-message">Hi! I am here to help answer your questions about Student Health and Wellness, try...</div>
            <div class="chatbot-message bot-message">Can Student Health and Wellness help with chronic medical conditions?</div>
            <div class="chatbot-message bot-message">Can I talk to a counselor at Student Health and Wellness?</div>
        </div>
        <div class="chatbot-footer">
            <input type="text" class="chatbot-input" id="userInput" placeholder="Ask a question">
            <button class="chatbot-send" onclick="sendMessage()">Send</button>
        </div>
    </div>

    <script>
        function toggleChatbot() {
            var chatbot = document.getElementById('chatbot');
            if (chatbot.style.display === 'none' || chatbot.style.display === '') {
                chatbot.style.display = 'flex';
            } else {
                chatbot.style.display = 'none';
            }
        }

        function sendMessage() {
            var input = document.getElementById('userInput');
            var message = input.value.trim();
            if (message !== '') {
                var messageBubble = document.createElement('div');
                messageBubble.className = 'chatbot-message user-message';
                messageBubble.textContent = message;
                document.getElementById('chatbotBody').appendChild(messageBubble);
                input.value = '';

                setTimeout(function() {
                    var botReply = document.createElement('div');
                    botReply.className = 'chatbot-message bot-message';
                    botReply.textContent = "This is a static reply, customize this to match user input.";
                    document.getElementById('chatbotBody').appendChild(botReply);
                }, 1000);
            }
        }
    </script>
</body>
</html>
