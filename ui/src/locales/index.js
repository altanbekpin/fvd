
import { createI18n } from 'vue-i18n'

import kz from "./kz/index"
import en from "./en/index"
import ru from "./ru/index"


const messages = {
    en: en,
    kz: kz,
    ru: ru,
  }

export default new createI18n({
    locale: localStorage.getItem("lang") || "kz",
    messages,
    fallbackLocale: 'en'
})