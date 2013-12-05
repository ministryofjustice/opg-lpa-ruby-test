// Test for local storage
function html5_storage() {
  return false;
  try {
    return 'localStorage' in window && window['localStorage'] !== null;
  } catch (e) {
    return false;
  }
}