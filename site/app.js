(function () {
  function sleep(ms) {
    return new Promise((r) => setTimeout(r, ms));
  }

  async function copyText(text) {
    // Primary: Clipboard API
    if (navigator.clipboard && window.isSecureContext) {
      await navigator.clipboard.writeText(text);
      return;
    }

    // Fallback: hidden textarea
    const ta = document.createElement("textarea");
    ta.value = text;
    ta.setAttribute("readonly", "");
    ta.style.position = "fixed";
    ta.style.left = "-9999px";
    ta.style.top = "0";
    document.body.appendChild(ta);
    ta.focus();
    ta.select();
    document.execCommand("copy");
    document.body.removeChild(ta);
  }

  async function handleCopy(btn) {
    const id = btn.getAttribute("data-copy");
    if (!id) return;

    const target = document.getElementById(id);
    if (!target) return;

    const text = (target.textContent || "").trim();
    if (!text) return;

    const original = btn.textContent;
    try {
      await copyText(text);
      btn.textContent = "Copied!";
      await sleep(900);
    } catch (e) {
      btn.textContent = "Copy failed";
      await sleep(900);
    } finally {
      btn.textContent = original;
    }
  }

  document.addEventListener("click", (ev) => {
    const el = ev.target;
    if (!(el instanceof HTMLElement)) return;

    const btn = el.closest("[data-copy]");
    if (!btn) return;

    ev.preventDefault();
    handleCopy(btn);
  });
})();

