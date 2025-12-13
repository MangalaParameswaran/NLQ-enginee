let currentSlide = 1;
const totalSlides = 10;

document.getElementById('totalSlides').textContent = totalSlides;

function createDots() {
    const dotsContainer = document.getElementById('slideDots');
    for (let i = 1; i <= totalSlides; i++) {
        const dot = document.createElement('div');
        dot.className = `slide-dot ${i === 1 ? 'active' : ''}`;
        dot.onclick = () => goToSlide(i);
        dotsContainer.appendChild(dot);
    }
}

function updateSlide() {
    document.querySelectorAll('.slide').forEach((slide, index) => {
        slide.classList.remove('active');
        if (index + 1 === currentSlide) {
            slide.classList.add('active');
        }
    });
    
    document.querySelectorAll('.slide-dot').forEach((dot, index) => {
        dot.classList.remove('active');
        if (index + 1 === currentSlide) {
            dot.classList.add('active');
        }
    });
    
    document.getElementById('currentSlide').textContent = currentSlide;
}

function changeSlide(direction) {
    currentSlide += direction;
    if (currentSlide < 1) currentSlide = totalSlides;
    if (currentSlide > totalSlides) currentSlide = 1;
    updateSlide();
}

function goToSlide(slideNum) {
    currentSlide = slideNum;
    updateSlide();
}

document.addEventListener('keydown', (e) => {
    if (e.key === 'ArrowRight' || e.key === ' ') {
        e.preventDefault();
        changeSlide(1);
    } else if (e.key === 'ArrowLeft') {
        e.preventDefault();
        changeSlide(-1);
    } else if (e.key === 'Home') {
        e.preventDefault();
        goToSlide(1);
    } else if (e.key === 'End') {
        e.preventDefault();
        goToSlide(totalSlides);
    }
});

document.querySelector('.slide-footer .date').textContent = new Date().toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long'
});

createDots();
