(function () {
  if (typeof mermaid !== "undefined") {
    mermaid.initialize({
      startOnLoad: true,
      theme: "dark",
      securityLevel: "strict"
    });
  }

  const btn = document.getElementById("copyDiagram");
  const diagram = document.getElementById("diagram");
  if (btn && diagram) {
    btn.addEventListener("click", async () => {
      try {
        await navigator.clipboard.writeText(diagram.textContent.trim());
        btn.textContent = "Copied!";
        setTimeout(() => (btn.textContent = "Copy diagram"), 1200);
      } catch (e) {
        btn.textContent = "Copy failed";
        setTimeout(() => (btn.textContent = "Copy diagram"), 1200);
      }
    });
  }
})();

