let skillsData = [];

function updateSkills(skills) {
    skillsData = Object.values(skills);
    renderSkills();
}

function renderSkills() {
    const skillsGrid = document.getElementById('skills-grid');
    skillsGrid.innerHTML = '';

    skillsData.forEach(skill => {
        const skillItem = document.createElement('div');
        skillItem.className = 'skill-item';
        skillItem.innerHTML = `
            <div class="skill-header">
                <span class="skill-name">${skill.name}</span>
                <div class="skill-info">
                    <span class="skill-xp">XP: ${skill.xp}</span>
                    <span class="skill-level">Level: ${skill.level}</span>
                </div>
            </div>
            <div class="skill-progress">
                <div class="skill-progress-bar" style="width: ${skill.progress}%"></div>
            </div>
        `;
        skillsGrid.appendChild(skillItem);
    });
}

function toggleUI(show) {
    const body = document.body;
    const container = document.getElementById('skills-container');
    
    if (show) {
        body.classList.add('active');
        container.style.display = 'block';
    } else {
        body.classList.remove('active');
        container.style.display = 'none';
    }
}

function closeUI() {
    toggleUI(false);
    fetch('https://sd_skills/closeUI', {method: 'POST'});
}

function refreshSkills() {
    fetch('https://sd_skills/refreshSkills', {method: 'POST'});
}

window.addEventListener('message', (event) => {
    if (event.data.action === 'updateSkills') {
        updateSkills(event.data.skills);
    } else if (event.data.action === 'toggleUI') {
        toggleUI(event.data.show);
    }
});

document.getElementById('close-button').addEventListener('click', closeUI);

document.getElementById('refresh-button').addEventListener('click', refreshSkills);

document.addEventListener('keydown', (event) => {
    if (event.key === 'Escape') {
        closeUI();
    }
});

renderSkills();