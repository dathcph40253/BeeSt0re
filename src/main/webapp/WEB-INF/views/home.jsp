<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Chat Widget Styles */
        .chat-widget {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 1000;
        }

        .chat-button {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: #1abc9c;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            transition: all 0.3s;
        }

        .chat-button:hover {
            background: #16a085;
            transform: scale(1.05);
        }

        .chat-container {
            position: fixed;
            bottom: 90px;
            right: 20px;
            width: 350px;
            height: 450px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            display: none;
            flex-direction: column;
            overflow: hidden;
        }

        .chat-header {
            background: linear-gradient(135deg, #1abc9c, #16a085);
            color: white;
            padding: 15px 20px;
            font-weight: 600;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(26, 188, 156, 0.3);
        }

        .chat-header .bot-name {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .chat-header .status-dot {
            width: 8px;
            height: 8px;
            background: #2ecc71;
            border-radius: 50%;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.5; }
            100% { opacity: 1; }
        }

        .chat-messages {
            flex: 1;
            padding: 15px;
            overflow-y: auto;
            max-height: 300px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .chat-messages::after {
            content: "";
            display: table;
            clear: both;
        }

        .message {
            margin-bottom: 12px;
            padding: 12px 15px;
            border-radius: 15px;
            font-size: 14px;
            line-height: 1.5;
            word-wrap: break-word;
            position: relative;
            display: block;
            width: fit-content;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            white-space: pre-line;
        }

        .message.user-message {
            background: linear-gradient(135deg, #007bff, #0056b3) !important;
            color: white !important;
            margin-left: auto !important;
            margin-right: 0 !important;
            border-bottom-right-radius: 5px !important;
            box-shadow: 0 2px 8px rgba(0, 123, 255, 0.4) !important;
            text-align: left !important;
            align-self: flex-end !important;
            max-width: 75% !important;
            border: none !important;
        }

        /* Specific override for user messages */
        #chatMessages .message.user-message {
            background: #007bff !important;
            color: white !important;
        }

        .message.bot-message {
            background: linear-gradient(135deg, #e8f5e8, #d4edda) !important;
            color: #155724 !important;
            margin-right: auto !important;
            margin-left: 0 !important;
            border-bottom-left-radius: 5px !important;
            border-left: 4px solid #28a745 !important;
            box-shadow: 0 2px 8px rgba(40, 167, 69, 0.2) !important;
            text-align: left !important;
            align-self: flex-start !important;
            max-width: 75% !important;
        }

        /* Specific override for bot messages */
        #chatMessages .message.bot-message {
            background: #e8f5e8 !important;
            color: #155724 !important;
            border-left: 4px solid #28a745 !important;
        }

        .typing-indicator {
            display: none;
            padding: 10px 15px;
            color: #666;
            font-style: italic;
            font-size: 13px;
        }

        .typing-dots {
            display: inline-block;
        }

        .typing-dots span {
            display: inline-block;
            width: 4px;
            height: 4px;
            border-radius: 50%;
            background: #1abc9c;
            margin: 0 1px;
            animation: typing 1.4s infinite ease-in-out;
        }

        .typing-dots span:nth-child(1) { animation-delay: -0.32s; }
        .typing-dots span:nth-child(2) { animation-delay: -0.16s; }

        @keyframes typing {
            0%, 80%, 100% { transform: scale(0); }
            40% { transform: scale(1); }
        }

        .chat-input {
            display: flex;
            padding: 15px;
            background: #f8f9fa;
            border-top: 1px solid #dee2e6;
        }

        .chat-input input {
            flex: 1;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 20px;
            outline: none;
        }

        .chat-input button {
            background: #1abc9c;
            color: white;
            border: none;
            border-radius: 20px;
            padding: 10px 15px;
            margin-left: 10px;
            cursor: pointer;
        }

        .chat-input button:hover {
            background: #16a085;
        }

        .chat-container.active {
            display: flex;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Sidebar -->
    <jsp:include page="admin/layout/sidebar.jsp"/>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Bar -->
        <jsp:include page="admin/layout/header.jsp"/>

        <!-- Dashboard Content -->
        <div class="dashboard">
            <h1>Dashboard</h1>

            <!-- Stats Cards: Chỉ hiện với ROLE_ADMIN hoặc ROLE_EMPLOYEE -->
            <c:if test="${sessionScope.user.role.name == 'ROLE_ADMIN' || sessionScope.user.role.name == 'ROLE_EMPLOYEE'}">
                <div class="stats-cards">
                    <div class="card">
                        <div class="card-icon" style="background: #e3f2fd;">
                            <i class="fas fa-shopping-cart" style="color: #1976d2;"></i>
                        </div>
                        <div class="card-info">
                            <h3>Tổng đơn hàng</h3>
                            <p>1,234</p>
                            <span class="trend up">+15% <i class="fas fa-arrow-up"></i></span>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-icon" style="background: #e8f5e9;">
                            <i class="fas fa-dollar-sign" style="color: #2e7d32;"></i>
                        </div>
                        <div class="card-info">
                            <h3>Doanh thu</h3>
                            <p>45.6M VNĐ</p>
                            <span class="trend up">+8% <i class="fas fa-arrow-up"></i></span>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-icon" style="background: #fff3e0;">
                            <i class="fas fa-users" style="color: #f57c00;"></i>
                        </div>
                        <div class="card-info">
                            <h3>Khách hàng</h3>
                            <p>856</p>
                            <span class="trend up">+12% <i class="fas fa-arrow-up"></i></span>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-icon" style="background: #fce4ec;">
                            <i class="fas fa-box" style="color: #c2185b;"></i>
                        </div>
                        <div class="card-info">
                            <h3>Sản phẩm</h3>
                            <p>432</p>
                            <span class="trend down">-3% <i class="fas fa-arrow-down"></i></span>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Đơn hàng gần đây: Luôn hiện với mọi role -->
            <div class="recent-orders">
                <div class="section-header">
                    <h2>Đơn hàng gần đây</h2>
                    <a href="/admin/order" class="view-all">Xem tất cả</a>
                </div>
                <div class="table-container">
                    <table>
                        <thead>
                        <tr>
                            <th>Mã đơn hàng</th>
                            <th>Khách hàng</th>
                            <th>Sản phẩm</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái</th>
                            <th>Thao tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>#ORD001</td>
                            <td>Nguyễn Văn A</td>
                            <td>3 sản phẩm</td>
                            <td>1,500,000 VNĐ</td>
                            <td><span class="status pending">Đang xử lý</span></td>
                            <td><button class="btn-view">Xem</button></td>
                        </tr>
                        <tr>
                            <td>#ORD002</td>
                            <td>Trần Thị B</td>
                            <td>2 sản phẩm</td>
                            <td>2,300,000 VNĐ</td>
                            <td><span class="status completed">Hoàn thành</span></td>
                            <td><button class="btn-view">Xem</button></td>
                        </tr>
                        <tr>
                            <td>#ORD003</td>
                            <td>Lê Văn C</td>
                            <td>1 sản phẩm</td>
                            <td>850,000 VNĐ</td>
                            <td><span class="status shipping">Đang giao</span></td>
                            <td><button class="btn-view">Xem</button></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- Chat Widget -->
<div class="chat-widget">
    <div class="chat-button" onclick="toggleChat()">
        <i class="fas fa-comments"></i>
    </div>

    <div class="chat-container" id="chatContainer">
        <div class="chat-header">
            <div class="bot-name">
                <span>🤖 BeeStore Assistant</span>
                <div class="status-dot"></div>
            </div>
            <i class="fas fa-times" onclick="toggleChat()" style="cursor: pointer;"></i>
        </div>

        <div class="chat-messages" id="chatMessages">
            <div class="message bot-message">
                Xin chào! Tôi là trợ lý ảo của BeeStore. Tôi có thể giúp bạn tìm sản phẩm, kiểm tra giá cả và thông tin. Bạn cần hỗ trợ gì? 😊
            </div>
        </div>

        <div class="typing-indicator" id="typingIndicator">
            🤖 Đang trả lời
            <div class="typing-dots">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </div>

        <div class="chat-input">
            <input type="text" id="chatInput" placeholder="Nhập tin nhắn..." onkeypress="handleKeyPress(event)">
            <button onclick="sendMessage()">
                <i class="fas fa-paper-plane"></i>
            </button>
        </div>
    </div>
</div>

<script>
function toggleChat() {
    const chatContainer = document.getElementById('chatContainer');
    chatContainer.classList.toggle('active');
}

function handleKeyPress(event) {
    if (event.key === 'Enter') {
        sendMessage();
    }
}

function sendMessage() {
    const input = document.getElementById('chatInput');
    const message = input.value.trim();

    if (message === '') return;

    // Add user message to chat
    addMessage(message, 'user');
    input.value = '';

    // Show typing indicator
    showTypingIndicator();

    // Timeout sau 10 giây
    const timeoutId = setTimeout(() => {
        hideTypingIndicator();
        addMessage('⏰ Phản hồi quá lâu, đang chuyển sang chế độ nhanh...', 'bot');
    }, 10000);

    // Send to backend
    fetch('/api/chatbot/chat', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ message: message })
    })
    .then(response => response.json())
    .then(data => {
        clearTimeout(timeoutId);
        hideTypingIndicator();
        addMessage(data.response, 'bot');
    })
    .catch(error => {
        clearTimeout(timeoutId);
        hideTypingIndicator();
        addMessage('Xin lỗi, có lỗi xảy ra. Vui lòng thử lại sau.', 'bot');
    });
}

function addMessage(message, sender) {
    const messagesContainer = document.getElementById('chatMessages');

    // Create message div with proper styling
    const messageDiv = document.createElement('div');
    messageDiv.className = `message ${sender}-message`;

    // Force styling based on sender
    if (sender === 'user') {
        messageDiv.style.background = 'linear-gradient(135deg, #007bff, #0056b3)';
        messageDiv.style.color = 'white';
        messageDiv.style.marginLeft = 'auto';
        messageDiv.style.marginRight = '0';
        messageDiv.style.alignSelf = 'flex-end';
        messageDiv.style.borderBottomRightRadius = '5px';
        messageDiv.style.boxShadow = '0 2px 8px rgba(0, 123, 255, 0.4)';
    } else if (sender === 'bot') {
        messageDiv.style.background = 'linear-gradient(135deg, #e8f5e8, #d4edda)';
        messageDiv.style.color = '#155724';
        messageDiv.style.marginRight = 'auto';
        messageDiv.style.marginLeft = '0';
        messageDiv.style.alignSelf = 'flex-start';
        messageDiv.style.borderLeft = '4px solid #28a745';
        messageDiv.style.borderBottomLeftRadius = '5px';
        messageDiv.style.boxShadow = '0 2px 8px rgba(40, 167, 69, 0.2)';
    }

    // Use innerHTML to preserve formatting
    messageDiv.innerHTML = message;

    // Add message to container
    messagesContainer.appendChild(messageDiv);

    // Scroll to bottom
    messagesContainer.scrollTop = messagesContainer.scrollHeight;
}

function showTypingIndicator() {
    const typingIndicator = document.getElementById('typingIndicator');
    typingIndicator.style.display = 'block';

    // Scroll to bottom
    const messagesContainer = document.getElementById('chatMessages');
    messagesContainer.scrollTop = messagesContainer.scrollHeight;
}

function hideTypingIndicator() {
    const typingIndicator = document.getElementById('typingIndicator');
    typingIndicator.style.display = 'none';
}
</script>

</body>
</html>
