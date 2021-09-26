import React, { Fragment } from "react";
import { Disclosure, Menu, Transition } from '@headlessui/react'
import { library } from "@fortawesome/fontawesome-svg-core";
import { fas } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
library.add(fas);

const Navbar = ({webUser}) => {
  const userDefault = {
    id: '訪客',
    email: '電子信箱',
    imageUrl:
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80',
  }
  webUser ? webUser : webUser = userDefault
  const user = {
    name: `${webUser.id}`,
    email: `${webUser.email}`,
    imageUrl: 
    'https://fakeimg.pl/250x100/',
  }

  const navigation = [
    { name: '主題企劃', href: '#', current: false },
    { name: '配件飾品', href: '#', current: false },
    { name: '居家生活', href: '#', current: false },
    { name: '品味美食', href: '#', current: false },
    { name: '餐桌廚房', href: '#', current: false },
  ]
  const userWithLogIn = [
    { name: '個人檔案', href: '/member/profile', method: 'get' },
    { name: '我的最愛', href: '#', method: 'get' },
    { name: '優惠卷', href: '#', method: 'get' },
    { name: '我的訂單', href: '/orders', method: 'get' },
    { name: '登入', href: '/users/sign_in', method: 'get' },
  ]
  const userWithLogOut = [
    { name: '個人檔案', href: '/member/profile', method: 'get' },
    { name: '我的最愛', href: '#', method: 'get' },
    { name: '優惠卷', href: '#', method: 'get' },
    { name: '我的訂單', href: '/orders', method: 'get' },
    { name: '登出', href: '/users/sign_out', method: 'delete' },
  ]

  function classNames(...classes) {
    return classes.filter(Boolean).join(' ')
  }

  const UserNav = ({data}) => {
    return (
      data.map((item) => (
        <Menu.Item key={item.name}>
          {({ active }) => (
            <a
              href={item.href}
              className={classNames(
                active ? 'bg-gray-100' : '',
                'block py-2 px-4 text-sm text-gray-700'
              )}
              data-method={item.method}
            >
              {item.name}
            </a>
          )}
        </Menu.Item>
      ))
    )
  }

  const UserNavigation = ({data}) => {
    return (
      data.map((item) => (
        <a
          key={item.name}
          href={item.href}
          className="block rounded-md py-2 px-3 text-base font-medium text-gray-500 hover:bg-gray-50 hover:text-gray-900"
          data-method={item.method}
        >
          {item.name}
        </a>
      ))
    )
  }

  return (
    <Disclosure as="header" className="bg-white shadow">
      {({ open }) => (
        <>
          <div className="max-w-7xl mx-auto px-2 sm:px-4 lg:divide-y lg:divide-gray-200 lg:px-8">
            <div className="relative h-16 flex justify-between">
              <div className="relative z-10 px-2 flex lg:px-0">
                <div className="flex-shrink-0 flex items-center">
                  <a href="/">
                    <img
                      className="block h-8 w-auto"
                      src="https://tailwindui.com/img/logos/workflow-mark-indigo-600.svg"
                      alt="Workflow"
                    />
                    </a>
                </div>
              </div>
              <div className="relative z-0 flex-1 px-2 flex items-center justify-center sm:absolute sm:inset-0">
                <div className="w-full sm:max-w-xs">
                  <form action="/products/search" method="GET">
                    <label htmlFor="search" className="sr-only">
                      Search
                    </label>
                    <div className="relative">
                      <div className="pointer-events-none absolute inset-y-0 left-0 pl-3 flex items-center">
                        <FontAwesomeIcon icon={['fas', 'search']} className="h-5 w-5 text-gray-400" aria-hidden="true" />
                      </div>
                      <input
                        id="search"
                        name="keyword"
                        className="block w-full bg-white border border-gray-300 rounded-md py-2 pl-10 pr-3 text-sm placeholder-gray-500 focus:outline-none focus:text-gray-900 focus:placeholder-gray-400 focus:ring-1 focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                        placeholder="搜尋好設計、體驗活動"
                        type="search"
                      />
                    </div>
                  </form>
                </div>
              </div>
              <div className="relative z-10 flex items-center lg:hidden">
                {/* Mobile menu button */}
                <Disclosure.Button className="rounded-md p-2 inline-flex items-center justify-center text-gray-400 hover:bg-gray-100 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-indigo-500">
                  <span className="sr-only">Open menu</span>
                  {open ? (
										<FontAwesomeIcon icon={['fas', 'times']} className="block h-6 w-6 text-2xl" aria-hidden="true" />
                  ) : (
										<FontAwesomeIcon icon={['fas', 'bars']}  className="block h-6 w-6 text-2xl" aria-hidden="true" />
                  )}
                </Disclosure.Button>
              </div>
              <div className="hidden lg:relative lg:z-10 lg:ml-4 lg:flex lg:items-center">
                {/* Profile dropdown */}
                <Menu as="div" className="flex-shrink-0 relative mr-4">
                  <div>
                    <Menu.Button className="bg-white rounded-full flex focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                      <span className="sr-only">Open user menu</span>
                        <img className="h-8 w-8 rounded-full" src={user.imageUrl} alt="" /> 
                    </Menu.Button>
                  </div>
                  <Transition
                    as={Fragment}
                    enter="transition ease-out duration-100"
                    enterFrom="transform opacity-0 scale-95"
                    enterTo="transform opacity-100 scale-100"
                    leave="transition ease-in duration-75"
                    leaveFrom="transform opacity-100 scale-100"
                    leaveTo="transform opacity-0 scale-95"
                  >
                    <Menu.Items className="origin-top-right absolute right-0 mt-2 w-48 rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5 py-1 focus:outline-none">
                      { webUser.id != '訪客' ? <UserNav data={userWithLogOut} /> : <UserNav data={userWithLogIn} /> }
                    </Menu.Items>
                  </Transition>
                </Menu>
                <button
                  type="button"
                  className="mr-4 flex-shrink-0 bg-white rounded-full p-1 text-gray-400 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                >
                  <span className="sr-only"></span>
                  <a href="/coupons">
                    <FontAwesomeIcon icon={['fas', 'ticket-alt']} className="h-6 w-6 text-2xl" aria-hidden="true" />
                  </a>
                </button>
                <button
                  type="button"
                  className="mr-4 flex-shrink-0 bg-white rounded-full p-1 text-gray-400 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                >
                  <span className="sr-only"></span>
                  <a href="/store">
                    <FontAwesomeIcon icon={['fas', 'store']} className="h-6 w-6 text-2xl" aria-hidden="true" />
                  </a>
                </button>
                <button
                  type="button"
                  className="mr-4 flex-shrink-0 bg-white rounded-full p-1 text-gray-400 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                >
                  <span className="sr-only"></span>
                  <a href="/cart">
                    <FontAwesomeIcon icon={['fas', 'shopping-cart']} className="h-6 w-6 text-2xl" aria-hidden="true" />
                  </a>
                </button>
              </div>
            </div>
            <nav className="hidden lg:py-2 lg:flex lg:space-x-8" aria-label="Global">
              {navigation.map((item) => (
                  <a
                    key={item.name}
                    href={item.href}
                    className={classNames(
                      item.current ? 'bg-gray-100 text-gray-900' : 'text-gray-900 hover:bg-gray-50 hover:text-gray-900',
                      'rounded-md py-2 px-3 inline-flex items-center text-sm font-medium'
                    )}
                    aria-current={item.current ? 'page' : undefined}
                  >
                    {item.name}
                  </a>
                ))}
            </nav>
          </div>

          <Disclosure.Panel as="nav" className="lg:hidden" aria-label="Global">
            <div className="pt-2 pb-3 px-2 space-y-1">
              {navigation.map((item) => (
                <a
                  key={item.name}
                  href={item.href}
                  className={classNames(
                    item.current ? 'bg-gray-100 text-gray-900' : 'text-gray-900 hover:bg-gray-50 hover:text-gray-900',
                    'block rounded-md py-2 px-3 text-base font-medium'
                  )}
                  aria-current={item.current ? 'page' : undefined}
                >
                  {item.name}
                </a>
              ))}
            </div>
            <div className="border-t border-gray-200 pt-4 pb-3">
              <div className="px-4 flex items-center">
                <div className="flex-shrink-0">
                  <img className="h-8 w-8 rounded-full" src={user.imageUrl} alt="" />
                </div>
                <div className="ml-3">
                  <div className="text-base font-medium text-gray-800">{user.name}</div>
                  <div className="text-sm font-medium text-gray-500">{user.email}</div>
                </div>
                <button
                  type="button"
                  className="ml-auto flex-shrink-0 bg-white rounded-full p-1 text-gray-400 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                >
                  <span className="sr-only"></span>
                  <a href="/coupons">
                    <FontAwesomeIcon icon={['fas', 'ticket-alt']} className="h-6 w-6 text-2xl" aria-hidden="true" />
                  </a>
                </button>
                <button
                  type="button"
                  className="ml-auto flex-shrink-0 bg-white rounded-full p-1 text-gray-400 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                >
                  <span className="sr-only"></span>
                  <a href="/store">
                    <FontAwesomeIcon icon={['fas', 'store']} className="h-6 w-6 text-2xl" aria-hidden="true" />
                  </a>
                </button>
                <button
                  type="button"
                  className="flex-shrink-0 bg-white rounded-full p-1 text-gray-400 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                >
                  <span className="sr-only"></span>
                  <a href="/cart">
                    <FontAwesomeIcon icon={['fas', 'shopping-cart']} className="h-6 w-6 text-2xl" aria-hidden="true" />
                  </a>
                </button>
              </div>
              <div className="mt-3 px-2 space-y-1">
                { webUser.id != '訪客' ? <UserNavigation data={userWithLogOut} /> : <UserNavigation data={userWithLogIn} /> }
              </div>
            </div>
          </Disclosure.Panel>
        </>
      )}
    </Disclosure>
  )
}

export default Navbar