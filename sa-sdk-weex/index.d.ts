declare module 'sa-sdk-weex' {
    declare type PropertiesType = string | number | boolean | Array<string>;
    declare type PropertiesObjectType = { [key: string]: PropertiesType }

    export enum SAAutoTrackType {
        START = 1,
        END = 2,
        CLICK = 4,
        VIEW_SCREEN = 8
    }

    export interface Config {
        server_url?: string,//数据接收地址，默认 ""
        show_log?: boolean,//是否显示日志,默认 false
        super_properties: Object, // 全局静态公共属性
        web: {   //web 初始化配置
            send_type: String,
            page_view: boolean,
            web_click: boolean,
            web_stay: boolean
        },
        app: {  // Android & iOS 初始化配置
            app_start: boolean,
            app_end: boolean,
            view_screen: boolean,
            view_click: boolean
            // 全埋点开关，默认不开启
            javascript_bridge?: boolean, //H5 打通开关，默认 false
        }
    }

    /**
     * 登录
     *
     * @param loginId 登录 Id
     */
    export function login(loginId: string): void;

    /**
     * 退出登录
     */
    export function logout(): void;

    /**
     * 设置用户属性
     *
     * @param profile 用户属性
     */
    export function setProfile(profile: PropertiesObjectType): void

    /**
     * 记录初次设定的属性
     *
     * @param profile 用户属性
     */
    export function setOnceProfile(profile: PropertiesObjectType): void

    /**
     * 增加用户属性数值
     * @param property 属性名
     * @param value 增量值
     */
    export function incrementProfile(property: String, value: Number): void

    /**
     * 追加用户属性
     * @param property 属性名
     * @param value 追加值
     */
    export function appendProfile(property: String, value: String): void

    /**
     * 删除用户属性
     * @param property 属性名
     */
    export function unsetProfile(property: String): void

    /**
     * 删除用户所有 Profile.
     */
    export function deleteProfile(): void;

    /**
     * 追踪事件
     *
     * @param event 事件名称
     * @param properties 事件属性
     */
    export function track(event: string, properties?: PropertiesObjectType | null): void;

    /**
     * 事件开始
     *
     * @param event 事件名称
     */
    export function trackTimerStart(event: string): void;

    /**
     * 事件结束
     *
     * @param event 事件名称
     * @param properties 事件属性
     */
    export function trackTimerEnd(event: string, properties?: PropertiesObjectType | null): void;

    /**
     * 清除所有事件计时器
     */
    export function clearTrackTimer(): void;

    /**
     * 切换页面的时候调用，用于记录 $AppViewScreen 事件..
     *
     * @param url 页面 url
     * @param properties 事件属性
     */
    export function trackViewScreen(url: string, properties?: PropertiesObjectType | null): void;

    /**
     * 设置的公共属性
     *
     * @param properties 公共属性
     */
    export function register(properties: PropertiesObjectType): void;

    /**
    * 删除指定公共属性
    *
    * @param properties 公共属性
    */
    export function unRegister(propName: String): void;

    /**
     * 删除全部公共属性
     *
     */
    export function clearRegister(): void;

    /**
     * 强制发送数据到服务端
     */
    export function flush(): void;

    /**
     * 删除本地数据库的所有数据！！！请谨慎使用
     */
    export function deleteAll(): void;

    /**
    /**
     * 替换“匿名 ID”
     *
     * @param anonymousId 传入的的匿名 ID，仅接受数字、下划线和大小写字母
     */
    export function identify(anonymousId: string): void;

    /**
     * 重置默认匿名 id
     */
    export function resetAnonymousId(): void;

    /**
     * 导出 trackTimerPause 方法给 RN 使用.
     *
     * <p>暂停事件计时器，计时单位为秒。
     *
     * @param eventName 事件的名称
     */
    export function trackTimerPause(eventName: string): void

    /**
     * 导出 trackTimerResume 方法给 RN 使用.
     *
     * <p>恢复事件计时器，计时单位为秒。
     *
     * @param eventName 事件的名称
     */
    export function trackTimerResume(eventName: string): void;

    /**
     * 设置当前 serverUrl
     *
     * @param serverUrl 当前 serverUrl
     */
    export function setServerUrl(serverUrl: string): void;

    /**
     * 设置 item
     *
     * @param itemType item 类型
     * @param itemId item ID
     * @param properties item 相关属性
     */
    export function setItem(itemType: string, itemId: string, properties?: PropertiesObjectType | null): void;

    /**
     * 删除 item
     *
     * @param itemType item 类型
     * @param itemId item ID
     */
    export function deleteItem(itemType: string, itemId: string): void;

    /**
     * 记录 $AppInstall 事件，用于在 App 首次启动时追踪渠道来源，并设置追踪渠道事件的属性。
     * 这是 Sensors Analytics 进阶功能，请参考文档 https://sensorsdata.cn/manual/track_installation.html
     *
     * @param properties 渠道追踪事件的属性
     */
    export function trackAppInstall(properties: PropertiesObjectType | null): void

    /**
     * 绑定业务 ID
     *
     * @param key ID
     * @param value 值
     */
    export function bind(key: string, value: string): void;

    /**
     * 解绑业务 ID
     *
     * @param key ID
     * @param value 值
     */
    export function unbind(key: string, value: string): void;

    /**
     * 初始化 SDK
     *
     * @param config Config
     */
    export function init(config: Config): void;

    export function useRouter(route: Route): void;
}