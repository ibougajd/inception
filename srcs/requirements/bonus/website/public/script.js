document.addEventListener('DOMContentLoaded', () => {
    // 1. Mobile & Burger Menu
    const burger = document.querySelector('.burger');
    const nav = document.querySelector('.nav-links');
    const navLinks = document.querySelectorAll('.nav-links li');

    const navSlide = () => {
        // Toggle Nav
        burger.addEventListener('click', () => {
            nav.classList.toggle('nav-active');

            // Burger Animation
            burger.classList.toggle('toggle');
        });

        // Close nav when clicking a link
        navLinks.forEach((link) => {
            link.addEventListener('click', () => {
                nav.classList.remove('nav-active');
                burger.classList.remove('toggle');
            });
        });
    };
    navSlide();

    // 2. Scroll Reveal Animation
    const sections = document.querySelectorAll('.section');
    
    // Add initial state for animation
    sections.forEach(section => {
        section.style.opacity = '0';
        section.style.transform = 'translateY(20px)';
        section.style.transition = 'all 0.6s ease-out';
    });

    const revealSection = (entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
                observer.unobserve(entry.target);
            }
        });
    };

    const sectionObserver = new IntersectionObserver(revealSection, {
        root: null,
        threshold: 0.15,
    });

    sections.forEach(section => {
        sectionObserver.observe(section);
    });

    // 3. Mouse Glow Effect
    const cursorGlow = document.querySelector('.cursor-glow');
    
    // Only enable glow on non-touch devices for performance
    if (window.matchMedia("(pointer: fine)").matches) {
        cursorGlow.style.opacity = '1';
        
        document.addEventListener('mousemove', (e) => {
            // Using requestAnimationFrame for better performance
            requestAnimationFrame(() => {
                cursorGlow.style.left = e.clientX + 'px';
                cursorGlow.style.top = e.clientY + 'px';
            });
        });
    }

    // 4. Glitch text animation triggering on random intervals (Optional fun)
    // currently CSS handles the static styling, JS could add random intensity
});
