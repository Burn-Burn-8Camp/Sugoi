import React, { Fragment, useState } from 'react'
import { Dialog, Menu, Transition } from '@headlessui/react'
import {
  BellIcon,
  ClockIcon,
  CogIcon,
  CreditCardIcon,
  DocumentReportIcon,
  HomeIcon,
  MenuAlt1Icon,
  QuestionMarkCircleIcon,
  ScaleIcon,
  ShieldCheckIcon,
  UserGroupIcon,
  XIcon,
} from '@heroicons/react/outline'
import {
  CashIcon,
  CheckCircleIcon,
  ChevronDownIcon,
  ChevronRightIcon,
  OfficeBuildingIcon,
  SearchIcon,
} from '@heroicons/react/solid'

const seller = [
  { name: '商店', icon: HomeIcon, current: false,
    lists: [{name: '編輯商店', url: '/store/edit' }] 
  },
  { name: '商品', icon: ClockIcon, current: false,
    lists: [{name: '新增商品', url: '#'},
            {name: '編輯商品', url: '#' }] 
  },
	{ name: '訂單', icon: ClockIcon, current: false,
	  lists: [{name: '訂單總攬', url: '#'},] 
  },  
]

const noonseller = [
	{ name: '商店', icon: HomeIcon, current: false,
	  lists: [{name: '創立商店', url: '/store/new' }] 
  },
]

const cards = [
  { name: 'Account balance', href: '#', icon: ScaleIcon, amount: '$30,659.45' },
  // More items...
]

const statusStyles = {
  success: 'bg-green-100 text-green-800',
  processing: 'bg-yellow-100 text-yellow-800',
  failed: 'bg-gray-100 text-gray-800',
}

function classNames(...classes) {
  return classes.filter(Boolean).join(' ')
}

const Sidebar = ({data}) => {
	return (
		<div className="px-2 space-y-1">
			{data.map((item) => (
				<div className="collapse collapse-arrow" key={item.name}>
					<input type="checkbox" /> 
					<div className='collapse-title text-xl font-medium'>
						{item.name}
					</div>
					<div className="collapse-content"> 
					{
						item.lists.map((li) => {
							return (
								<span key={li.name}>
									<a href={li.url}><p>{li.name}</p></a>
								</span>
							)
						})
					}
					</div> 
				</div> 
			))}
    </div>


	)
}

const StorePage = ({store}) => {
  const [sidebarOpen, setSidebarOpen] = useState(false)
	console.log(store)
  return (
    <div className="relative h-screen flex overflow-hidden bg-white">
      <Transition.Root show={sidebarOpen} as={Fragment}>
        <Dialog as="div" className="fixed inset-0 flex z-40 lg:hidden" onClose={setSidebarOpen}>
          <Transition.Child
            as={Fragment}
            enter="transition-opacity ease-linear duration-300"
            enterFrom="opacity-0"
            enterTo="opacity-100"
            leave="transition-opacity ease-linear duration-300"
            leaveFrom="opacity-100"
            leaveTo="opacity-0"
          >
            <Dialog.Overlay className="fixed inset-0 bg-gray-600 bg-opacity-75" />
          </Transition.Child>
          <Transition.Child
            as={Fragment}
            enter="transition ease-in-out duration-300 transform"
            enterFrom="-translate-x-full"
            enterTo="translate-x-0"
            leave="transition ease-in-out duration-300 transform"
            leaveFrom="translate-x-0"
            leaveTo="-translate-x-full"
          >
            <div className="relative flex-1 flex flex-col max-w-xs w-full pt-5 pb-4 bg-white">
              <Transition.Child
                as={Fragment}
                enter="ease-in-out duration-300"
                enterFrom="opacity-0"
                enterTo="opacity-100"
                leave="ease-in-out duration-300"
                leaveFrom="opacity-100"
                leaveTo="opacity-0"
              >
                <div className="absolute top-0 right-0 -mr-12 pt-2">
                  <button
                    type="button"
                    className="ml-1 flex items-center justify-center h-10 w-10 rounded-full focus:outline-none focus:ring-2 focus:ring-inset focus:ring-white"
                    onClick={() => setSidebarOpen(false)}
                  >
                    <span className="sr-only">Close sidebar</span>
                    <XIcon className="h-6 w-6 text-white" aria-hidden="true" />
                  </button>
                </div>
              </Transition.Child>
              <div className="flex-shrink-0 flex items-center px-4">
                <h2 className='text-2xl text-white ml-2'>SUGOII</h2>
              </div>
              <nav className="mt-5 flex-shrink-0 h-full divide-y divide-cyan-800 overflow-y-auto" aria-label="Sidebar">
						  	{
							    store ? <Sidebar data={seller}/> : <Sidebar data={noonseller}/>
					    	}
              </nav>
            </div>
          </Transition.Child>
          <div className="flex-shrink-0 w-14" aria-hidden="true">
            {/* Dummy element to force sidebar to shrink to fit close icon */}
          </div>
        </Dialog>
      </Transition.Root>

      {/* Static sidebar for desktop */}
      <div className="hidden lg:flex lg:flex-shrink-0">
        <div className="flex flex-col w-64">
          {/* Sidebar component, swap this element with another sidebar if you like */}
          <div className="flex flex-col flex-grow bg-red-300 pt-5 pb-8 overflow-y-auto">
            <div className="flex items-center flex-shrink-0 px-4">
              <img src="/images/阿榮偷看.png" alt="" />
            </div>
            <nav className="mt-5 flex-1 flex flex-col divide-y divide-cyan-800 overflow-y-auto" aria-label="Sidebar">
						  {
						  	store ? <Sidebar data={seller}/> : <Sidebar data={noonseller}/>
						  }

            </nav>
          </div>
        </div>
      </div>

      <div className="flex-1 overflow-auto focus:outline-none">
        <div className="relative  flex-shrink-0 flex h-16 bg-red-300 border-b border-gray-200 lg:border-none">
          <button
            type="button"
            className="px-4 border-r border-gray-200 text-gray-400 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-cyan-500 lg:hidden"
            onClick={() => setSidebarOpen(true)}
          >
            <span className="sr-only">Open sidebar</span>
            <MenuAlt1Icon className="h-6 w-6 text-black" aria-hidden="true" />
          </button>
        </div>
      </div>
      <div className='dragon'>
        <img src="/images/商店內圖.png" alt="" />
      </div>
    </div>
  )
}

export default StorePage