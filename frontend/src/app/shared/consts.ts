export const AUTH_MODULE = 'auth';
export const SYSTEM_MODULE = 'system';

export const SIGNIN_PAGE = 'signin';
export const PROFILE_PAGE = 'profile';
export const NEWS_PAGE = 'news';
export const ADMIN_PANEL_PAGE = 'admin-panel';
export const MATERIALS_PAGE = 'materials';
export const SCHEDULE_REPRESENTATIVE_PAGE = 'schedule-common';
export const MY_SCHEDULE_PAGE = 'my-schedule';
export const REPRESENTATIVE_PANEL_PAGE = 'representative-panel';
export const ATTENDANCE_PAGE = 'attendance';

export const ME = 'me';
export const ACCEPT_IMAGES = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];

export const LINK_PAGE_SIGNIN = `/${AUTH_MODULE}/${SIGNIN_PAGE}`;
export const LINK_PAGE_PROFILE_SHORT = `/${SYSTEM_MODULE}/${PROFILE_PAGE}`;
export const LINK_PAGE_PROFILE = `/${LINK_PAGE_PROFILE_SHORT}/${ME}`;
export const LINK_PAGE_NEWS = `/${SYSTEM_MODULE}/${NEWS_PAGE}`;
export const LINK_PAGE_ADMIN_PANEL = `/${SYSTEM_MODULE}/${ADMIN_PANEL_PAGE}`;
export const LINK_PAGE_MATERIALS = `/${SYSTEM_MODULE}/${MATERIALS_PAGE}`;
export const LINK_PAGE_REPRESENTATIVE_PANEL = `/${SYSTEM_MODULE}/${REPRESENTATIVE_PANEL_PAGE}`;
export const LINK_PAGE_SCHEDULE_REPRESENTATIVE = `/${SYSTEM_MODULE}/${SCHEDULE_REPRESENTATIVE_PAGE}`;
export const LINK_PAGE_MY_SCHEDULE = `/${SYSTEM_MODULE}/${MY_SCHEDULE_PAGE}`;
export const LINK_PAGE_ATTENDANCE = `/${SYSTEM_MODULE}/${ATTENDANCE_PAGE}`;

export const NAME_REDUCER_PROFILE = 'profile';

export const ADMIN_ROLE = 1;
export const REPRESENTATIVE_ROLE = 2;
export const TEACHER_ROLE = 3;
export const STUDENT_ROLE = 4;
export const FORMAT_DATE = 'yyyy-MM-dd';
export const LOCALE_RU = 'ru';
export const EMAIL_SUPPORT = 'm.fokina2020@mail.ru';

export const FILE_ICONS = new Map([
  ['ai', 'ai.png'],
  ['bmp', 'bmp.png'],
  ['cdr', 'cdr.png'],
  ['dmg', 'dmg.png'],
  ['doc', 'doc.png'],
  ['docx', 'docx.png'],
  ['dwf', 'dwf.png'],
  ['dwg', 'dwg.png'],
  ['eps', 'eps.png'],
  ['exe', 'exe.png'],
  ['htm', 'htm.png'],
  ['html', 'html.png'],
  ['ini', 'ini.png'],
  ['java', 'java.png'],
  ['jpg', 'jpg.png'],
  ['mov', 'mov.png'],
  ['mp4', 'mp4.png'],
  ['mpg', 'mpg.png'],
  ['pdf', 'pdf.png'],
  ['php', 'php.png'],
  ['png', 'png.png'],
  ['ppt', 'ppt.png'],
  ['pptx', 'pptx.png'],
  ['psd', 'psd.png'],
  ['rar', 'rar.png'],
  ['rss', 'rss.png'],
  ['rtf', 'rtf.png'],
  ['sys', 'sys.png'],
  ['txt', 'txt.png'],
  ['xls', 'xls.png'],
  ['xlsx', 'xlsx.png'],
  ['zip', 'zip.png'],
]);
