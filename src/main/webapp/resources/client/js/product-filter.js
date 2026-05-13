$(document).ready(function() {
    
    // Hàm gọi API
    function fetchFilteredProducts(page = 0) {
        let os = $('#osSelect').val();
        let factory = $('#factorySelect').val();
        let target = $('#targetSelect').val();

        let rams = $('input[name="ram"]:checked').map(function(){return $(this).val();}).get();
        let roms = $('input[name="rom"]:checked').map(function(){return $(this).val();}).get();
        let screenSizes = $('input[name="screenSize"]:checked').map(function(){return $(this).val();}).get();
        let batteries = $('input[name="battery"]:checked').map(function(){return $(this).val();}).get();
        let refreshRates = $('input[name="refreshRate"]:checked').map(function(){return $(this).val();}).get();
        let fastCharges = $('input[name="fastCharge"]:checked').map(function(){return $(this).val();}).get();

        let priceRange = $('input[name="price"]:checked').val() || '';
        let keyword = $('#searchInput').val();
        let sort = $('.sort-btn.active').data('sort');

        const productGrid = document.getElementById('productGrid');
        productGrid.innerHTML = '<div class="col"><div class="skeleton-card"></div></div>'.repeat(8);

        // Đổi trạng thái nút Tìm Kiếm sang Đang load
        const btnApply = $('#btnApplyFilter');
        btnApply.prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-1"></i> Đang lọc...');

        $.ajax({
            url: '/api/products/filter',
            type: 'GET',
            data: { 
                os: os, factory: factory, target: target,
                ram: rams, rom: roms, screenSize: screenSizes,
                battery: batteries, refreshRate: refreshRates, fastCharge: fastCharges,
                priceRange: priceRange, keyword: keyword, sort: sort, page: page 
            },
            success: function(response) {
                renderProducts(response.content);
                renderPagination(response);
            },
            error: function() {
                productGrid.innerHTML = '<div class="col-12 text-center text-danger py-5 fw-bold">Lỗi kết nối máy chủ!</div>';
            },
            complete: function() {
                // Nhả trạng thái nút sau khi gọi xong
                btnApply.prop('disabled', false).html('<i class="fas fa-search me-1"></i> Tìm kiếm');
            }
        });
    }

    // Render Sản phẩm (ĐÃ SỬA LỖI LẶP CODE)
    function renderProducts(products) {
        const productGrid = document.getElementById('productGrid');
        productGrid.innerHTML = "";

      if (!products || products.length === 0) {
            productGrid.innerHTML = `
                <div class="col-12 d-flex flex-column justify-content-center align-items-center text-center w-100" style="min-height: 50vh;">
                    <img src="https://cdn-icons-png.flaticon.com/512/7486/7486754.png" width="120" style="opacity:0.5; margin-bottom:20px;">
                    <h5 class="text-dark fw-bold mt-2">Không tìm thấy sản phẩm phù hợp</h5>
                    <p class="text-muted">Rất tiếc, không có sản phẩm nào khớp với bộ lọc. Vui lòng thử lại.</p>
                </div>
            `;
            return;
        }

        let html = '';
        let csrfToken = $('input[name="_csrf"]').val() || ''; 
        const formatter = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' });

        products.forEach(p => {
            let specs = '';
            if (p.screenSize) specs += `<span><i class="fas fa-mobile-alt me-1"></i>${p.screenSize}</span>`;
            if (p.ram) specs += `<span><i class="fas fa-memory me-1"></i>${p.ram}</span>`;
            if (p.rom) specs += `<span><i class="fas fa-hdd me-1"></i>${p.rom}</span>`;
            if (p.battery) specs += `<span><i class="fas fa-battery-full me-1"></i>${p.battery}</span>`;

            html += `
            <div class="col">
                <div class="product-card">
                    <a href="/product/${p.id}" class="text-center">
                        <img src="/images/product/${p.image}" class="img-fluid" onerror="this.src='/resources/client/img/single-item.jpg'">
                    </a>
                    <div class="mt-auto">
                        <a href="/product/${p.id}" class="p-name">${p.name}</a>
                        <div class="specs-mini">${specs}</div>
                        <div class="p-price mb-2">${formatter.format(p.price)}</div>
                        
                        <form action="/add-product-to-cart/${p.id}" method="post">
                            <input type="hidden" name="_csrf" value="${csrfToken}" />
                            <button type="submit" class="btn btn-outline-danger w-100 rounded-pill fw-bold py-2" style="font-size: 13px;">Mua ngay</button>
                        </form>
                    </div>
                </div>
            </div>`;
        });
        
        $('#productGrid').hide().html(html).fadeIn(500);
    }

    // Render Phân Trang
    function renderPagination(pageData) {
        const pag = document.getElementById('pagination');
        pag.innerHTML = "";
        if (!pageData || pageData.totalPages <= 1) return;
        
        let html = '<ul class="pagination pagination-md shadow-sm">';
        for (let i = 0; i < pageData.totalPages; i++) {
            html += `<li class="page-item ${i === pageData.number ? 'active' : ''}">
                        <a class="page-link shadow-none ${i === pageData.number ? 'bg-danger border-danger text-white' : 'text-dark'}" 
                           href="javascript:void(0)" onclick="changePage(${i})">${i + 1}</a>
                     </li>`;
        }
        html += '</ul>';
        pag.innerHTML = html;
    }

    window.changePage = function(page) { fetchFilteredProducts(page); };

    // 1. Nút Áp dụng (Tìm kiếm)
    $('#btnApplyFilter').on('click', function() {
        fetchFilteredProducts(0);
    });

    // 2. Nút Xóa Lọc
    $('#btnClearFilter').on('click', function() {
        $('.filter-checkbox').prop('checked', false);
        $('select.form-select').val(''); 
        $('#searchInput').val('');
        $('#p0').prop('checked', true); // Tick lại 'Tất cả' khoảng giá
        
        $('.sort-btn').removeClass('active');
        $('[data-sort="newest"]').addClass('active');
        
        fetchFilteredProducts(0); // Call API reset về mặc định
    });

    // 3. Thanh tìm kiếm: Chỉ chạy khi ấn Enter
    $('#searchInput').on('keypress', function(e) {
        if (e.which === 13) { 
            fetchFilteredProducts(0);
            return false; 
        }
    });

    // 4. Các nút Sort
    $('.sort-btn').on('click', function() {
        $('.sort-btn').removeClass('active');
        $(this).addClass('active');
        fetchFilteredProducts(0);
    });
});