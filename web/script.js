let appVisible = false;

// Kalau resource awak pakai ox_lib NUI callback, endpoint tetap sama:
// https://<resourceName>/close
function postNui(eventName, data = {}) {
  fetch(`https://${GetParentResourceName()}/${eventName}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json; charset=UTF-8' },
    body: JSON.stringify(data),
  }).catch(() => {});
}

function setVisible(visible) {
  const app = document.getElementById('app');
  appVisible = visible;
  app.classList.toggle('hidden', !visible);
}

function renderJobs(jobCounts, logoPath) {
  const grid = document.getElementById('jobsGrid');
  grid.innerHTML = '';

  // jobCounts datang dari Lua sebagai object { police: 1, ambulance: 0, ... }
  // label/icon kita simpan di dataset kecil; tapi lebih baik kalau awak nak, kita boleh pass dari Lua juga.
  // Untuk sekarang: ikut Config.Jobs di server -> ia akan hantar keys yang sama.
  const jobMeta = [
    { name: 'police', label: 'POLICE', icon: '👮' },
    { name: 'ambulance', label: 'EMS', icon: '🚑' },
    { name: 'mechanic', label: 'MECHANIC', icon: '🔧' },
    { name: 'taxi', label: 'TAXI', icon: '🚕' },
    { name: 'burger', label: 'BURGER', icon: '🍔' },
    { name: 'cardealer', label: 'DEALER', icon: '🚗' },
  ];

  // set logo
  const logoEl = document.getElementById('serverLogo');
  if (logoPath) logoEl.src = logoPath;

  for (const jm of jobMeta) {
    const val = (jobCounts && jobCounts[jm.name]) ? jobCounts[jm.name] : 0;

    const card = document.createElement('div');
    card.className = 'jobCard';
    card.innerHTML = `
      <div class="jobTop">
        <div class="jobLabel">${jm.label}</div>
        <div class="jobIcon">${jm.icon}</div>
      </div>
      <div class="jobValue">${val}</div>
    `;
    grid.appendChild(card);
  }
}

function renderHeists(heists) {
  const list = document.getElementById('heistsList');
  list.innerHTML = '';
  (heists || []).forEach(h => {
    const row = document.createElement('div');
    row.className = 'heistRow';
    row.innerHTML = `
      <div class="heistName">${h.name}</div>
      <div class="badge ${h.available ? 'yes' : 'no'}">${h.available ? 'YES' : 'NO'}</div>
    `;
    list.appendChild(row);
  });
}

window.addEventListener('message', (event) => {
  const { action, data } = event.data || {};

  if (action === 'setVisible') {
    setVisible(!!data.visible);
  }

  if (action === 'open') {
    setVisible(true);
  }

  if (action === 'close') {
    setVisible(false);
  }

  if (action === 'updateServerData') {
    document.getElementById('totalPlayers').textContent = data.totalPlayers ?? 0;

    // IMPORTANT: untuk logo, kita set path relative dlm web/dist (img/logo.png)
    // server hantar "img/logo.png" -> kita letak terus.
    renderJobs(data.jobs || {}, data.serverLogo || '');
    renderHeists(data.heists || []);
  }
});

document.getElementById('btnClose').addEventListener('click', () => {
  postNui('close', {});
});

// ESC untuk tutup
document.addEventListener('keydown', (e) => {
  if (!appVisible) return;
  if (e.key === 'Escape') postNui('close', {});
});
