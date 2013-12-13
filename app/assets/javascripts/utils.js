// Test for local storage
function html5_storage() {
  try {
    return 'sessionStorage' in window && window['sessionStorage'] !== null;
  } catch (e) {
    return false;
  }
}
