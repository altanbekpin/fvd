<template>
	<div class="layout-topbar">
		<router-link to="/" class="layout-topbar-logo">
			<img alt="Logo" :src="topbarImage()" />
		</router-link>
		<button class="p-link layout-menu-button layout-topbar-button" @click="onMenuToggle">
			<i class="pi pi-bars"></i>
		</button>
		<span>{{$t("common.title")}}</span>

		<button class="p-link layout-topbar-menu-button layout-topbar-button"
			v-styleclass="{ selector: '@next', enterClass: 'hidden', enterActiveClass: 'scalein', 
			leaveToClass: 'hidden', leaveActiveClass: 'fadeout', hideOnOutsideClick: true}">
			<i class="pi pi-ellipsis-v"></i>
		</button>

		<ul class="layout-topbar-menu hidden lg:flex origin-top">
			<li>
				<Dropdown class="p-link" v-model="language" :options="languages" optionLabel="name" @change="changeLanguage" />
			</li>
			
		</ul>
		<button class="p-link layout-topbar-button" @click="$router.push('/auth')"><i class="pi pi-user"></i><span>Profile</span></button>
		
	</div>
</template>

<script>
export default {
	data() {
		return {
			languages: [
				{	name:	"Қазақ", value: "kz"},
				{	name:	"Русский", value: "ru"},
				{	name:	"English", value: "en"},
			],
			language : null,
		}
	},
    methods: {
        onMenuToggle(event) {
            this.$emit('menu-toggle', event);
        },
		changeLanguage() {
			if (this.$i18n.locale !== this.language.value) {
				localStorage.setItem("lang", this.language.value);
				this.$i18n.locale = this.language.value
			}

			switch(this.$i18n.locale) {
				case "kz":
					this.$primevue.config.locale.startsWith = 'Басталады',
					this.$primevue.config.locale.contains = 'Арасында бар',
					this.$primevue.config.locale.notContains = 'Арасында жоқ',
					this.$primevue.config.locale.endsWith = 'Аяқталады',
					this.$primevue.config.locale.equals = 'Тең',
					this.$primevue.config.locale.notEquals = 'Тең емес',
					this.$primevue.config.locale.noFilter = 'Фильтр жоқ',
					this.$primevue.config.locale.lt = 'Кіші',
					this.$primevue.config.locale.lte = 'Кіші не тең',
					this.$primevue.config.locale.gt = 'Үлкен',
					this.$primevue.config.locale.gte = 'Үлкен не тең',
					this.$primevue.config.locale.dateIs = 'Көрсетілген күні',
					this.$primevue.config.locale.dateIsNot = 'Көрсетілген күннен басқа',
					this.$primevue.config.locale.dateBefore = 'Көрсетілген күннен бұрын',
					this.$primevue.config.locale.dateAfter = 'Көрсетілген күннен кейін',
					this.$primevue.config.locale.clear = 'Тазалау',
					this.$primevue.config.locale.apply = 'Қолдану',
					this.$primevue.config.locale.matchAll = 'Барлығына сәйкес келу',
					this.$primevue.config.locale.matchAny = 'Кез келгеніне сәйкес келу',
					this.$primevue.config.locale.addRule = 'Ереже қосу',
					this.$primevue.config.locale.removeRule = 'Ережені өшіру',
					this.$primevue.config.locale.accept = 'Йә',
					this.$primevue.config.locale.reject = 'Жоқ',
					this.$primevue.config.locale.choose = 'Таңдау',
					this.$primevue.config.locale.upload = 'Жүктеу',
					this.$primevue.config.locale.cancel  =  'Бас тарту',
					this.$primevue.config.locale.dayNames = ["Жексені", "Дүйсенбі", "Сейсенбі", "Сәрсенбі", "Бейсенбі", "Жұма", "Сенбі"],
					this.$primevue.config.locale.dayNamesShort = ["Жек", "Дүй", "Сей", "Сәр", "Бей", "Жұма", "Сен"],
					this.$primevue.config.locale.dayNamesMin = ["Же","Дү","Се","Сә","Бе","Жұ","Сн"],
					this.$primevue.config.locale.monthNames = ["Қаңтар","Ақпан","Наурыз","Сәуір","Мамыр","Маусым","Шілде","Тамыз","Қыркүйек","Қазан","Қараша","Желтоқсан"],
					this.$primevue.config.locale.monthNamesShort= ["Қаң","Ақп","Нау","Сәу","Мам","Мау","Шіл","Там","Қыр","Қаз","Қар","Жел"],
					this.$primevue.config.locale.today = 'Бүгін',
					this.$primevue.config.locale.weekHeader = 'Ат',
					this.$primevue.config.locale.firstDayOfWeek = 1,
					this.$primevue.config.locale.dateFormat = 'mm.dd.yyyy',
					this.$primevue.config.locale.weak = 'Әлсіз',
					this.$primevue.config.locale.medium = 'Орташа',
					this.$primevue.config.locale.strong = 'Күшті',
					this.$primevue.config.locale.passwordPrompt = 'Кілт сөзді енгізіңіз',
					this.$primevue.config.locale.emptyFilterMessage = 'Еш нәтиже табылмады',
					this.$primevue.config.locale.emptyMessage  = 'Қол жетімді опциялар жоқ'
					break;
				case "ru":
					this.$primevue.config.locale.startsWith = 'Начинается с',
					this.$primevue.config.locale.contains = 'Содержит',
					this.$primevue.config.locale.notContains = 'Не содержит',
					this.$primevue.config.locale.endsWith = 'Заканчивается на ',
					this.$primevue.config.locale.equals = 'Равно',
					this.$primevue.config.locale.notEquals = 'Не равно',
					this.$primevue.config.locale.noFilter = 'Нет фильтр',
					this.$primevue.config.locale.lt = 'Меньше',
					this.$primevue.config.locale.lte = 'Меньше или равно',
					this.$primevue.config.locale.gt = 'Больше',
					this.$primevue.config.locale.gte = 'Больше или равно',
					this.$primevue.config.locale.dateIs = 'Дата',
					this.$primevue.config.locale.dateIsNot = 'Кроме',
					this.$primevue.config.locale.dateBefore = 'Дата до',
					this.$primevue.config.locale.dateAfter = 'Дата после',
					this.$primevue.config.locale.clear = 'Очистить',
					this.$primevue.config.locale.apply = 'Применить',
					this.$primevue.config.locale.matchAll = 'Соответствовать всем',
					this.$primevue.config.locale.matchAny = 'Cоответствовать любому',
					this.$primevue.config.locale.addRule = 'Добавить правило',
					this.$primevue.config.locale.removeRule = 'Удалить правило ',
					this.$primevue.config.locale.accept = 'Да',
					this.$primevue.config.locale.reject = 'Нет',
					this.$primevue.config.locale.choose = 'Выбрать',
					this.$primevue.config.locale.upload = 'Заргузить',
					this.$primevue.config.locale.cancel  =  'Отменить',
					this.$primevue.config.locale.dayNames = ["Воскресенье", "Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота"],
					this.$primevue.config.locale.dayNamesShort = ["Вскр", "Пон", "Втр", "Ср", "Чтв", "Пт", "Сбт"],
					this.$primevue.config.locale.dayNamesMin = ["Вс","Пн","Вт","Ср","Чт","Пт","Сб"],
					this.$primevue.config.locale.monthNames = ["Январь","Февраль","Март","Апрель","Май","Июнь","Июль","Август","Сентябрь","Октябрь","Ноябрь","Декабрь"],
					this.$primevue.config.locale.monthNamesShort= ["Янв","Фев","Мрт","Апр","Май","Июн","Июл","Авг","Сен","Окт","Нбр","Дек"],
					this.$primevue.config.locale.today = 'Сегодня',
					this.$primevue.config.locale.weekHeader = 'Зн',
					this.$primevue.config.locale.firstDayOfWeek = 1,
					this.$primevue.config.locale.dateFormat = 'mm.dd.yyyy',
					this.$primevue.config.locale.weak = 'Слабый',
					this.$primevue.config.locale.medium = 'Средний',
					this.$primevue.config.locale.strong = 'Сильный',
					this.$primevue.config.locale.passwordPrompt = 'Введите пароль',
					this.$primevue.config.locale.emptyFilterMessage = 'Записей не найдено',
					this.$primevue.config.locale.emptyMessage  = 'Нет доступных опций'
					break;
				case "en":
					this.$primevue.config.locale.startsWith = 'Starts with',
			this.$primevue.config.locale.contains = 'Contains',
			this.$primevue.config.locale.notContains =  'Not contains',
			this.$primevue.config.locale.endsWith =  'Ends with',
			this.$primevue.config.locale.equals =  'Equals',
			this.$primevue.config.locale.notEquals =  'Not equals',
			this.$primevue.config.locale.noFilter =  'No Filter',
			this.$primevue.config.locale.lt =  'Less than',
			this.$primevue.config.locale.lte =  'Less than or equal to',
			this.$primevue.config.locale.gt =  'Greater than',
			this.$primevue.config.locale.gte =  'Greater than or equal to',
			this.$primevue.config.locale.dateIs =  'Date is',
			this.$primevue.config.locale.dateIsNot =  'Date is not',
			this.$primevue.config.locale.dateBefore =  'Date is before',
			this.$primevue.config.locale.dateAfter =  'Date is after',
			this.$primevue.config.locale.clear =  'Clear',
			this.$primevue.config.locale.apply =  'Apply',
			this.$primevue.config.locale.matchAll =  'Match All',
			this.$primevue.config.locale.matchAny =  'Match Any',
			this.$primevue.config.locale.addRule =  'Add Rule',
			this.$primevue.config.locale.removeRule =  'Remove Rule',
			this.$primevue.config.locale.accept =  'Yes',
			this.$primevue.config.locale.reject =  'No',
			this.$primevue.config.locale.choose =  'Choose',
			this.$primevue.config.locale.upload =  'Upload',
			this.$primevue.config.locale.cancel =  'Cancel',
			this.$primevue.config.locale.dayNames =  ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
			this.$primevue.config.locale.dayNamesShort =  ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
			this.$primevue.config.locale.dayNamesMin =  ["Su","Mo","Tu","We","Th","Fr","Sa"],
			this.$primevue.config.locale.monthNames =  ["January","February","March","April","May","June","July","August","September","October","November","December"],
			this.$primevue.config.locale.monthNamesShort =  ["Jan", "Feb", "Mar", "Apr", "May", "Jun","Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
			this.$primevue.config.locale.today =  'Today',
			this.$primevue.config.locale.weekHeader =  'Wk',
			this.$primevue.config.locale.firstDayOfWeek =  0,
			this.$primevue.config.locale.dateFormat =  'mm/dd/yy',
			this.$primevue.config.locale.weak =  'Weak',
			this.$primevue.config.locale.medium =  'Medium',
			this.$primevue.config.locale.strong =  'Strong',
			this.$primevue.config.locale.passwordPrompt =  'Enter a password',
			this.$primevue.config.locale.emptyFilterMessage =  'No results found',
			this.$primevue.config.locale.emptyMessage =  'No available options'
					break;
			}
		},
		onTopbarMenuToggle(event) {
            this.$emit('topbar-menu-toggle', event);
        },
		topbarImage() {
			return this.$appState.darkTheme ? 'images/logo-enu.svg' : 'images/logo-enu.svg';
		}
    },
	created() {
		localStorage.setItem("lang", this.$i18n.locale);
			this.language = this.languages.filter(function(item) {
				return item.value === localStorage.getItem("lang")
			})[0];
			this.changeLanguage();
	},
	computed: {
		darkTheme() {
			return this.$appState.darkTheme;
		}
	}
}
</script>
<style scoped>
.pi-usericon{
	margin-right: 20px;
	margin-left: 20px;
}
.layout-topbar .layout-topbar-button {
    display: inline-flex;
    justify-content: center;
    align-items: center;
    position: relative;
    color: var(--text-color-secondary);
    border-radius: 50%;
    width: 3rem;
    height: 3rem;
    cursor: pointer;
    transition: background-color .2s
}
.p-link {
    text-align: left;
    background-color: transparent;
    margin: 0;
    padding: 0;
    border: 0;
    cursor: pointer;
    user-select: none
}
</style>