/*!
    * Start Bootstrap - SB Admin v7.0.7 (https://startbootstrap.com/template/sb-admin)
    * Copyright 2013-2023 Start Bootstrap
    * Licensed under MIT (https://github.com/StartBootstrap/startbootstrap-sb-admin/blob/master/LICENSE)
    */
    // 
// Scripts
// 

window.addEventListener('DOMContentLoaded', event => {

    // Toggle the side navigation
    const sidebarToggle = document.body.querySelector('#sidebarToggle');
    if (sidebarToggle) {
        // Uncomment Below to persist sidebar toggle between refreshes
        // if (localStorage.getItem('sb|sidebar-toggle') === 'true') {
        //     document.body.classList.toggle('sb-sidenav-toggled');
        // }
        sidebarToggle.addEventListener('click', event => {
            event.preventDefault();
            document.body.classList.toggle('sb-sidenav-toggled');
            localStorage.setItem('sb|sidebar-toggle', document.body.classList.contains('sb-sidenav-toggled'));
        });
    }

});
document.addEventListener("DOMContentLoaded", function() {
    // 1. Khai báo các thành phần giao diện
    const searchInput = document.getElementById('searchInput');
    const tableBody = document.getElementById('tableBody');
    const searchSpinner = document.getElementById('searchSpinner');
    
    // Nếu trang hiện tại không có ô search thì dừng script
    if (!searchInput || !tableBody) return;

    const pageType = searchInput.getAttribute('data-type'); // Lấy 'user', 'product' hoặc 'order'
    let debounceTimer;

    // 2. Lắng nghe sự kiện nhập liệu
    searchInput.addEventListener('input', function(e) {
        const keyword = e.target.value.trim();
        
        // Hiển thị loading animation
        if (searchSpinner) searchSpinner.style.display = 'inline-block';
        
        // Xóa timer cũ nếu người dùng vẫn đang gõ
        clearTimeout(debounceTimer);
        
        // Thiết lập timer mới (Chờ 500ms sau khi ngừng gõ mới gửi request)
        debounceTimer = setTimeout(() => {
            fetchSearchData(keyword);
        }, 500);
    });

    // 3. Hàm gửi AJAX request
    function fetchSearchData(keyword) {
        const url = `/admin/${pageType}/search?keyword=${encodeURIComponent(keyword)}`;

        fetch(url)
            .then(response => {
                if (!response.ok) throw new Error('Network response was not ok');
                return response.json();
            })
            .then(data => {
                if (searchSpinner) searchSpinner.style.display = 'none';
                renderTable(data);
            })
            .catch(error => {
                console.error('Error:', error);
                if (searchSpinner) searchSpinner.style.display = 'none';
            });
    }

    // 4. Hàm vẽ lại bảng dữ liệu
   function renderTable(data) {
        tableBody.innerHTML = ''; // Xóa sạch dữ liệu cũ

        if (data.length === 0) {
            tableBody.innerHTML = `
                <tr>
                    <td colspan="10" class="text-center py-5">
                        <div class="empty-state-modern">
                            <i class="fas fa-search-minus fa-3x text-muted mb-3"></i>
                            <p class="text-secondary">Không tìm thấy dữ liệu phù hợp</p>
                        </div>
                    </td>
                </tr>`;
            return;
        }

        // Duyệt qua danh sách và tạo HTML cho từng hàng
        data.forEach((item, index) => {
            let row = `<tr>`;
            
            // Cột ID dùng chung
            row += `<td>${item.id}</td>`; 

            // CÁC CỘT DỮ LIỆU CHÍNH & BADGE TÙY CHỈNH THEO TRANG
            if (pageType === 'user') {
                const badgeClass = item.role === 'ADMIN' ? 'bg-primary' : 'bg-info text-dark';
                row += `
                    <td>${item.email}</td>
                    <td>${item.fullName}</td>
                    <td>${item.phone || ''}</td>
                    <td><span class="badge ${badgeClass}">${item.role}</span></td>
                `;
            } 
            else if (pageType === 'product') {
                row += `
                    <td>${item.name}</td>
                    <td>${new Intl.NumberFormat('vi-VN').format(item.price)} đ</td>
                    <td>${item.quantity}</td>
                    <td>${item.factory || ''}</td>
                `;
            } 
            else if (pageType === 'order') {
                // Tùy biến màu sắc badge theo trạng thái đơn hàng
                let badgeClass = "bg-primary";
                if(item.status === 'SUCCESS' || item.status === 'DELIVERED') badgeClass = 'bg-success';
                else if(item.status === 'CANCELLED') badgeClass = 'bg-danger';
                else if(item.status === 'PENDING') badgeClass = 'bg-warning text-dark';

                row += `
                    <td>${item.receiverName}</td>
                    <td>${item.receiverPhone}</td>
                    <td>${item.receiverAddress}</td>
                    <td>${new Intl.NumberFormat('vi-VN').format(item.totalPrice)} đ</td>
                    <td><span class="badge ${badgeClass}">${item.status}</span></td>
                `;
            }

            // CỘT CHỨC NĂNG (ACTION BUTTONS) - CHUẨN BOOTSTRAP
            row += `
                <td>
                    <a href="/admin/${pageType}/${item.id}" class="btn btn-success btn-sm me-1">
                        Xem chi tiết
                    </a>
                    <a href="/admin/${pageType}/update/${item.id}" class="btn btn-warning btn-sm me-1">
                        Sửa
                    </a>
                    <a href="/admin/${pageType}/delete/${item.id}" class="btn btn-danger btn-sm">
                        Xóa
                    </a>
                </td>
            </tr>`;
            
            // Gắn hàng mới vào bảng
            tableBody.insertAdjacentHTML('beforeend', row);
        });
        
        // Kích hoạt hiệu ứng fade-in mượt mà
        tableBody.classList.remove('table-fade-in');
        void tableBody.offsetWidth; 
        tableBody.classList.add('table-fade-in');
    }
});if (pageType === 'user') {
    // Logic Badge màu xanh đồng bộ với JSP
    const badgeClass = item.role === 'ADMIN' ? 'bg-primary' : 'bg-info text-dark';
    
    rowHtml += `
        <td>${item.email}</td>
        <td>${item.fullName}</td>
        <td>${item.phone || ''}</td>
        <td>
            <span class="badge rounded-pill ${badgeClass} px-3 text-uppercase">${item.role}</span>
        </td>
    `;
}
function filterRevenue() {
    const start = document.getElementById('startDate').value;
    const end = document.getElementById('endDate').value;
    if(!start || !end) return alert("Vui lòng chọn đầy đủ ngày!");

    fetch(`/admin/order/revenue/filter?startDate=${start}&endDate=${end}`)
        .then(res => res.json())
        .then(data => {
            let html = '';
            let total = 0;
            data.forEach(item => {
                html += `<tr>
                    <td>${item.id}</td>
                    <td>${item.receiverName}</td>
                    <td>${item.receiverPhone}</td>
                    <td>${new Intl.NumberFormat('vi-VN').format(item.totalPrice)} đ</td>
                    <td><span class="badge bg-success">${item.status}</span></td>
                </tr>`;
                total += item.totalPrice;
            });
            document.getElementById('revenueTableBody').innerHTML = html;
            document.getElementById('totalRevenue').innerText = new Intl.NumberFormat('vi-VN').format(total);
        });
}

// Hàm gọi API /admin/order/revenue/filter
function filterRevenueAJAX() {
    const start = document.getElementById('startDate').value;
    const end = document.getElementById('endDate').value;
    
    if(!start || !end) {
        alert("Vui lòng chọn đầy đủ Từ ngày và Đến ngày!");
        return;
    }

    fetch(`/admin/order/revenue/filter?startDate=${start}&endDate=${end}`)
        .then(res => res.json())
        .then(data => {
            let html = '';
            let total = 0;

            if(data.length === 0) {
                html = `<tr><td colspan="7" class="text-center py-4 text-muted">Không có dữ liệu doanh thu trong khoảng thời gian này.</td></tr>`;
            } else {
                data.forEach(item => {
                    html += `<tr>
                        <td class="text-center">${item.id}</td>
                        <td>${item.receiverName}</td>
                        <td>${item.receiverPhone}</td>
                        <td class="text-center">${item.orderDate}</td>
                        <td class="text-center">${item.deliveredDate}</td>
                        <td class="text-end fw-bold">${new Intl.NumberFormat('vi-VN').format(item.totalPrice)} đ</td>
                        <td class="text-center"><span class="badge bg-success">DELIVERED</span></td>
                    </tr>`;
                    total += item.totalPrice;
                });
            }

            // Render lại bảng
            document.getElementById('revenueTableBody').innerHTML = html;
            // Cập nhật tổng tiền
            document.querySelector('.table-warning .text-danger').innerHTML = new Intl.NumberFormat('vi-VN').format(total) + ' đ';
        })
        .catch(error => {
            console.error('Lỗi khi lọc doanh thu:', error);
            alert("Đã xảy ra lỗi khi tải dữ liệu!");
        });
}

// Hàm xuất file Excel (giữ nguyên logic gọi API export của bạn)
function exportExcel() {
    const start = document.getElementById('startDate').value;
    const end = document.getElementById('endDate').value;
    if(!start || !end) {
        alert("Vui lòng lọc khoảng ngày trước khi xuất Excel!");
        return;
    }
    window.location.href = `/admin/order/revenue/export?startDate=${start}&endDate=${end}`;
}
// Hàm phụ trợ để định dạng ngày từ chuỗi ISO trả về từ API
function formatDate(dateStr) {
    if (!dateStr) return "";
    // Nếu dateStr là "12/05/2026 10:30:00" -> lấy 10 ký tự đầu
    if (dateStr.includes(" ")) {
        return dateStr.split(" ")[0];
    }
    return dateStr;
}

// Khi render Timeline:
let html = `<li><strong>Ngày đặt hàng:</strong> ${formatDate(order.orderDate)}</li>`;