<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <title>Hóa đơn vận chuyển #${order.id}</title>
                <style>
                    body {
                        font-family: "Times New Roman", Times, serif;
                        font-size: 14px;
                        margin: 0;
                        padding: 0;
                    }

                    .invoice-container {
                        width: 100mm;
                        margin: auto;
                        padding: 10px;
                        border: 1px solid #000;
                    }

                    .header {
                        display: flex;
                        justify-content: space-between;
                        border-bottom: 2px dashed #000;
                        padding-bottom: 10px;
                    }

                    .shop-info {
                        width: 60%;
                    }

                    .order-barcode {
                        width: 35%;
                        text-align: right;
                    }

                    .section {
                        border-bottom: 1px dashed #000;
                        padding: 10px 0;
                    }

                    .label {
                        font-weight: bold;
                        text-transform: uppercase;
                        font-size: 12px;
                        display: block;
                        margin-bottom: 5px;
                    }

                    .info-box {
                        display: grid;
                        grid-template-columns: 1fr 1fr;
                        gap: 10px;
                    }

                    .table-products {
                        width: 100%;
                        border-collapse: collapse;
                        margin-top: 10px;
                    }

                    .table-products th,
                    .table-products td {
                        border: 1px solid #000;
                        padding: 5px;
                        text-align: left;
                    }

                    .total-section {
                        text-align: right;
                        margin-top: 10px;
                        font-weight: bold;
                        font-size: 16px;
                    }

                    .footer {
                        margin-top: 20px;
                        display: flex;
                        justify-content: space-between;
                        text-align: center;
                    }

                    .signature {
                        height: 60px;
                    }

                    /* CSS cho việc in ấn */
                    @media print {
                        @page {
                            size: A5;
                            margin: 0;
                        }

                        body {
                            padding: 10mm;
                        }

                        .no-print {
                            display: none;
                        }
                    }
                </style>
                <script src="https://cdn.jsdelivr.net/npm/jsbarcode@3.11.5/dist/JsBarcode.all.min.js"></script>
            </head>

            <body onload="generateBarcode(); window.print();">

                <div class="invoice-container">
                    <div class="header">
                        <div class="shop-info">
                            <div style="font-weight: bold; font-size: 16px;">LongHang Mobile</div>
                            <div>Địa chỉ: Ngã Tư, Việt Hùng, Hiệp Hòa, Bắc Ninh</div>
                            <div>SĐT: 0826166996</div>
                        </div>
                        <div class="order-barcode">
                            <svg id="barcode"></svg>
                            <div style="text-align: center">Mã đơn: #${order.id}</div>
                        </div>
                    </div>

                    <div class="section">
                        <span class="label">Người nhận:</span>
                        <div style="font-weight: bold; font-size: 15px;">${order.receiverName}</div>
                        <div>SĐT: ${order.receiverPhone}</div>
                        <div>Địa chỉ: ${order.receiverAddress}</div>
                    </div>

                    <div class="section">
                        <span class="label">Nội dung hàng hóa:</span>
                        <table class="table-products">
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Sản phẩm</th>
                                    <th>SL</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="detail" items="${orderDetails}" varStatus="status">
                                    <tr>
                                        <td>${status.index + 1}</td>
                                        <td>${detail.product.name}</td>
                                        <td>${detail.quantity}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="total-section">
                        TIỀN THU HỘ (COD):
                        <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="đ" />
                    </div>

                    <div class="section" style="font-style: italic; font-size: 12px;">
                        Ghi chú: Cho khách xem hàng, không thử. Quay video khi bóc hàng để được hỗ trợ.
                    </div>

                    <div class="footer">
                        <div>
                            <div class="label">Chữ ký người gửi</div>
                            <div class="signature"></div>
                            <div>(Xác nhận hàng nguyên vẹn)</div>
                        </div>
                        <div>
                            <div class="label">Chữ ký người nhận</div>
                            <div class="signature"></div>
                            <div>(Xác nhận đã nhận hàng)</div>
                        </div>
                    </div>
                </div>

                <script>
                    function generateBarcode() {
                        JsBarcode("#barcode", "${order.id}", {
                            format: "CODE128",
                            width: 1.5,
                            height: 40,
                            displayValue: false
                        });
                    }
                </script>
            </body>

            </html>