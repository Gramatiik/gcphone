import skinsConfig from '../components/settings/skins.json'
import wallpapersConfig from '../components/settings/wallpapers.json'

JSON.parseOrDefault = function (json, def) {
  try {
    const decoded = JSON.parse(json)
    return decoded || def
  } catch (e) {
    console.error('Unable to parse JSON...')
    return def
  }
}

export default function () {
  return {
    messages: [],
    contacts: [],
    skin: JSON.parseOrDefault(localStorage.getItem('gcphone:skin'), skinsConfig[0]),
    wallpaper: JSON.parseOrDefault(localStorage.getItem('gcphone:wallpaper'), wallpapersConfig[0]),
    zoomFactor: localStorage.getItem('gcphone:zoomFactor') || '100%',
    show: true,
    phoneNumber: ''
  }
}
