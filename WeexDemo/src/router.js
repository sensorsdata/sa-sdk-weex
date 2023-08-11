/* global Vue */
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'
import One from '@/components/One.vue'
import Two from '@/components/Two.vue'
import Three from '@/components/Three.vue'
import Tab from '@/components/Tab.vue'
import Tab1 from '@/components/Tab1.vue'
import Tab2 from '@/components/Tab2.vue'
import Home from '@/components/Home.vue'
import Widget from '@/components/Widget.vue'
import Event from '@/components/Event.vue'

export const router = new Router({
  routes: [
    {
      path: '/',
      name: 'HelloWorld',
      component: HelloWorld
    },
    {
      path: '/home',
      name: 'Home',
      component: Home,
      props: { title: "HomeTitle" }
    },
    {
      path: '/widget',
      name: 'Widget',
      component: Widget,
      props: { title: "WidgetTitle" }
    },
    {
      path: '/event',
      name: 'Event',
      component: Event,
      props: { title: "EventTitle" }
    },
    {
      path: '/one/:id/:title',
      // path:'/one',
      name: 'One',
      component: One,

      // props:{sensors:{title:"title"}}
    },
    {
      path: '/two',
      // path:'/one',
      name: 'Two',
      component: Two,
      props: {
        title: "头条",
        path:'custom_two_path',
        sa_props: { superKey: 'superValue' }
      }
    },
    {
      path: '/three',
      // path:'/one',
      name: 'Three',
      props: true,
      component: Three,
    }, {
      path: "/tab",
      component: Tab,
      name: 'Tab',
      // 重定向
      // redirect: '/tab1',
      children: [
        // 子路由规则
        { path: "/tab1", name: 'Tab1', component: Tab1, props: { title: 'Tab1Title', sa_props: { superKey: 'superValue' } } },
        { path: "/tab2", name: 'Tab2', component: Tab2 },
      ],
    },
  ]
})