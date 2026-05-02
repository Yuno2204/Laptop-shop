(function ($) {
    "use strict";

    // Spinner
    var spinner = function () {
        setTimeout(function () {
            if ($('#spinner').length > 0) {
                $('#spinner').removeClass('show');
            }
        }, 1);
    };
    spinner(0);


    // Fixed Navbar
    $(window).scroll(function () {
        if ($(window).width() < 992) {
            if ($(this).scrollTop() > 55) {
                $('.fixed-top').addClass('shadow');
            } else {
                $('.fixed-top').removeClass('shadow');
            }
        } else {
            if ($(this).scrollTop() > 55) {
                $('.fixed-top').addClass('shadow').css('top', 0);
            } else {
                $('.fixed-top').removeClass('shadow').css('top', 0);
            }
        }
    });


    // Back to top button
    $(window).scroll(function () {
        if ($(this).scrollTop() > 300) {
            $('.back-to-top').fadeIn('slow');
        } else {
            $('.back-to-top').fadeOut('slow');
        }
    });
    $('.back-to-top').click(function () {
        $('html, body').animate({ scrollTop: 0 }, 1500, 'easeInOutExpo');
        return false;
    });


    // Testimonial carousel
    $(".testimonial-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 2000,
        center: false,
        dots: true,
        loop: true,
        margin: 25,
        nav: true,
        navText: [
            '<i class="bi bi-arrow-left"></i>',
            '<i class="bi bi-arrow-right"></i>'
        ],
        responsiveClass: true,
        responsive: {
            0: {
                items: 1
            },
            576: {
                items: 1
            },
            768: {
                items: 1
            },
            992: {
                items: 2
            },
            1200: {
                items: 2
            }
        }
    });


    // vegetable carousel
    $(".vegetable-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 1500,
        center: false,
        dots: true,
        loop: true,
        margin: 25,
        nav: true,
        navText: [
            '<i class="bi bi-arrow-left"></i>',
            '<i class="bi bi-arrow-right"></i>'
        ],
        responsiveClass: true,
        responsive: {
            0: {
                items: 1
            },
            576: {
                items: 1
            },
            768: {
                items: 2
            },
            992: {
                items: 3
            },
            1200: {
                items: 4
            }
        }
    });


    // Modal Video
    $(document).ready(function () {
        var $videoSrc;
        $('.btn-play').click(function () {
            $videoSrc = $(this).data("src");
        });
        console.log($videoSrc);

        $('#videoModal').on('shown.bs.modal', function (e) {
            $("#video").attr('src', $videoSrc + "?autoplay=1&amp;modestbranding=1&amp;showinfo=0");
        })

        $('#videoModal').on('hide.bs.modal', function (e) {
            $("#video").attr('src', $videoSrc);
        })
    });



   // Product Quantity
    $('.quantity button').on('click', function () {
        let change = 0;
        const button = $(this);
        const input = button.parent().parent().find('input');
        const oldValue = parseFloat(input.val());
        let newVal = oldValue;

        if (button.hasClass('btn-plus')) {
            newVal = oldValue + 1;
            change = 1;
        } else {
            if (oldValue > 1) {
                newVal = oldValue - 1;
                change = -1;
            } else {
                newVal = 1;
            }
        }

        input.val(newVal);
        const index = input.attr("data-cart-detail-index");
        const el = document.getElementById(`cartDetails${index}.quantity`);
        $(el).val(newVal);

        // get price
        const price = +input.attr("data-cart-detail-price");
        const id = input.attr("data-cart-detail-id");

        // update thành tiền từng sản phẩm
        const priceElement = $(`p[data-cart-detail-id='${id}']`);
        if (priceElement.length) {
            const newPrice = price * newVal;
            priceElement.text(formatCurrency(newPrice) + " đ");
        }

        // update total cart price
        const totalPriceElement = $(`p[data-cart-total-price]`);
        let newTotal = 0;

        if (totalPriceElement.length) {
            const currentTotal = +totalPriceElement.first().attr("data-cart-total-price");

            if (change === 0) {
                newTotal = currentTotal;
            } else {
                newTotal = currentTotal + change * price;
            }

            totalPriceElement.each(function () {
                $(this).text(formatCurrency(newTotal) + " đ");
                $(this).attr("data-cart-total-price", newTotal);
            });
        }
    });

    function formatCurrency(value) {
        const formatter = new Intl.NumberFormat('vi-VN', {
            style: 'decimal',
            minimumFractionDigits: 0,
            maximumFractionDigits: 0
        });

        return formatter.format(value);
    }
    $(document).on('click', '.btn-delete-cart', function () {
    const cartDetailId = $(this).attr('data-cart-detail-id');
    $('#delete-cart-form').attr('action', '/delete-cart-product/' + cartDetailId);
});
document.getElementById("btn-confirm-checkout").addEventListener("click", function () {
    // Lấy tất cả input quantity đang hiển thị
    document.querySelectorAll("input[data-cart-detail-id]").forEach(function (input) {
        var id = input.getAttribute("data-cart-detail-id");
        var qty = input.value;
        // Cập nhật vào hidden input tương ứng
        var hiddenInput = document.getElementById("hidden-qty-" + id);
        if (hiddenInput) {
            hiddenInput.value = qty;
        }
    });
    document.getElementById("confirm-checkout-form").submit();
});
})(jQuery);

