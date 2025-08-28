// Carga de llamados + login/register/postulación
document.addEventListener('DOMContentLoaded', () => {
  cargarLlamados();
  wireUI();
});

function cargarLlamados() {
  fetch('./api/routes/llamados.php', { credentials: 'include' })
    .then(r => r.json())
    .then(data => {
      const jobsGrid = document.getElementById('container');
      if (!jobsGrid) return;
      jobsGrid.innerHTML = '';
      const empleosActivos = document.getElementById('empleos-activos');
      if (empleosActivos) empleosActivos.textContent = data.llamados.length;

      // Header user state
      const btnIngresar = document.getElementById('btn-ingresar');
      const btnSalir = document.getElementById('btn-salir');
      const perfilLink = document.getElementById('link-perfil');
      if (data.logged) {
        if (btnIngresar) btnIngresar.classList.add('hidden');
        if (btnSalir) btnSalir.classList.remove('hidden');
        if (perfilLink) perfilLink.classList.remove('hidden');
        const nom = document.getElementById('usuario-nombre');
        if (nom && data.nombre) nom.textContent = data.nombre;
      } else {
        if (btnIngresar) btnIngresar.classList.remove('hidden');
        if (btnSalir) btnSalir.classList.add('hidden');
        if (perfilLink) perfilLink.classList.add('hidden');
      }

      data.llamados.forEach(ll => {
        const ya = Number(ll.ya_postulado) === 1; // <— clave
        const btnClass = ya
          ? 'bg-gray-400 cursor-not-allowed'
          : 'bg-blue-600 hover:bg-blue-700';
        const btnAttrs = ya ? 'disabled aria-disabled="true"' : '';

        const card = document.createElement('div');
        card.className = 'job-card bg-white rounded-lg shadow-sm border border-gray-200 p-6 hover:shadow-md';
        const logo = ll.logo ? `<img src="${ll.logo}" alt="Logo" class="w-12 h-12 rounded-lg object-cover">` : '';
        const empresa = ll.empresa_nombre ? `<p class="text-sm text-gray-500">Empresa: ${escapeHtml(ll.empresa_nombre)}</p>` : '';
        card.innerHTML = `
          <div class="flex items-start justify-between mb-2">
            <div class="flex items-start gap-3">
              ${logo}
              <div>
                <h3 class="text-lg font-semibold text-gray-800">${escapeHtml(ll.titulo)}</h3>
                ${empresa}
              </div>
            </div>
            <span class="text-xs px-2 py-1 rounded bg-gray-100 text-gray-600">#${ll.id}</span>
          </div>
          <p class="text-gray-700 text-sm leading-relaxed mb-4">${escapeHtml(ll.descripcion ?? '')}</p>
          <div class="flex justify-end">
            <button ${btnAttrs} data-id="${ll.id}"
              class="btn-postular text-white text-sm px-4 py-2 rounded ${btnClass}">
              ${ya ? 'Ya postulado' : 'Postularse'}
            </button>
          </div>
        `;
        jobsGrid.appendChild(card);
      });

      // Listeners para postular (sólo en botones habilitados)
      document.querySelectorAll('.btn-postular').forEach(btn => {
        if (btn.hasAttribute('disabled')) return; // ya postulado, no agregar handler
        btn.addEventListener('click', async e => {
          const b = e.currentTarget;
          const llamado_id = b.getAttribute('data-id');
          const res = await fetch('./api/routes/postular.php', {
            method: 'POST',
            credentials: 'include',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: new URLSearchParams({ llamado_id })
          });
          if (res.status === 401) {
            abrirModal('modal-login');
            return;
          }
          const j = await res.json();
          if (j.ok) {
            // Marcar en vivo sin recargar
            b.textContent = 'Ya postulado';
            b.classList.remove('bg-blue-600', 'hover:bg-blue-700');
            b.classList.add('bg-gray-400', 'cursor-not-allowed');
            b.setAttribute('disabled', 'true');
            b.setAttribute('aria-disabled', 'true');
          } else {
            alert(j.msg || 'No se pudo postular');
          }
        });
      });
    })
    .catch(() => {
      const jobsGrid = document.getElementById('container');
      if (jobsGrid) jobsGrid.innerHTML = '<p class="text-red-600">Error al cargar los llamados.</p>';
    });
}

function wireUI() {
  // Abrir y cerrar modales
  document.querySelectorAll('[data-open]').forEach(btn => {
    btn.addEventListener('click', () => abrirModal(btn.getAttribute('data-open')));
  });
  document.querySelectorAll('[data-close]').forEach(btn => {
    btn.addEventListener('click', () => cerrarModal(btn.getAttribute('data-close')));
  });

  // Login
  const fLogin = document.getElementById('form-login');
  if (fLogin) {
    fLogin.addEventListener('submit', async e => {
      e.preventDefault();
      const fd = new FormData(fLogin);
      const res = await fetch('./api/routes/login.php', {
        method: 'POST',
        credentials: 'include',
        body: new URLSearchParams(fd)
      });
      const j = await res.json();
      if (j.ok) {
        cerrarModal('modal-login');
        cargarLlamados();
      } else {
        alert(j.msg || 'Error de login');
      }
    });
  }

  // Registro
  const fReg = document.getElementById('form-register');
  if (fReg) {
    fReg.addEventListener('submit', async e => {
      e.preventDefault();
      const fd = new FormData(fReg);
      const res = await fetch('./api/routes/register.php', {
        method: 'POST',
        credentials: 'include',
        body: new URLSearchParams(fd)
      });
      const j = await res.json();
      if (j.ok) {
        alert('Usuario creado. Ahora iniciá sesión.');
        cerrarModal('modal-register');
        abrirModal('modal-login');
      } else {
        alert(j.msg || 'Error al registrar');
      }
    });
  }

  // Logout
  const btnSalir = document.getElementById('btn-salir');
  if (btnSalir) {
    btnSalir.addEventListener('click', async () => {
      await fetch('./api/routes/logout.php', { credentials: 'include' });
      cargarLlamados();
    });
  }

  // Ver perfil
  const linkPerfil = document.getElementById('link-perfil');
  if (linkPerfil) {
    linkPerfil.addEventListener('click', async e => {
      e.preventDefault();
      const res = await fetch('./api/routes/perfil.php', { credentials: 'include' });
      if (res.status === 401) { abrirModal('modal-login'); return; }
      const j = await res.json();
      const lista = document.getElementById('perfil-lista');
      lista.innerHTML = '';
      j.postulaciones.forEach(p => {
        const li = document.createElement('li');
        li.className = 'text-sm text-gray-700';
        li.textContent = `#${p.llamado_id} - ${p.titulo} (${p.fecha_postulacion})`;
        lista.appendChild(li);
      });
      abrirModal('modal-perfil');
    });
  }
}

function abrirModal(id) {
  const el = document.getElementById(id);
  if (el) el.classList.remove('hidden');
}
function cerrarModal(id) {
  const el = document.getElementById(id);
  if (el) el.classList.add('hidden');
}
function escapeHtml(str) {
  return (str ?? '').toString().replace(/[&<>"']/g, s => ({
    '&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'
  }[s]));
}
