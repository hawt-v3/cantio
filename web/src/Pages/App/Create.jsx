import { Menu, Popover, Transition } from "@headlessui/react";
import { BellIcon, MenuIcon, XIcon } from "@heroicons/react/outline";
import { SearchIcon } from "@heroicons/react/solid";
import detectEthereumProvider from "@metamask/detect-provider";
import { Fragment, useEffect, useRef, useState } from "react";
import { useNavigate } from "react-router-dom";
import TypeAnimation from "react-type-animation";
import { v4 } from "uuid";
import { navigation, userNavigation } from ".";
import { Dropdown } from "../../Components/Dropdown";
import firebase from "../../firebase";
import { checkIfRegistered, intiializeUser } from "../../Services/Auth";

const genres = [
  {
    id: 1,
    name: "Rock",
  },
  {
    id: 2,
    name: "Blues",
  },

  {
    id: 3,
    name: "Hiphop",
  },
  {
    id: 4,
    name: "Pop",
  },
  {
    id: 5,
    name: "Metal",
  },
  {
    id: 6,
    name: "Indie",
  },
  {
    id: 7,
    name: "Chill",
  },
];

function classNames(...classes) {
  return classes.filter(Boolean).join(" ");
}

const Create = () => {
  const navigate = useNavigate();
  const [started, setStarted] = useState();
  const [user, setUser] = useState(null);
  const [selectedGenre, setSelectedGenre] = useState(genres[0]);
  const [fileUrl, setFileUrl] = useState("");
  const [uploading, setUploading] = useState(0);
  const inputRef = useRef();
  const nameRef = useRef();

  useEffect(async () => {
    const provider = await detectEthereumProvider();
    if (!provider) {
      // check if the user's public key is in the firestore db, trigger the create user flow if not
      alert("Missing eth provider.");
      return;
    }

    // check for existing token in localstorage
    let token = window.localStorage.getItem("token");
    let account = null;

    if (!token) {
      account = await window.ethereum.request({
        method: "eth_requestAccounts",
      });

      if (!account || account.length === 0) {
        alert("Please install metamask.");
        return;
      }
      token = account[0];
    }

    window.localStorage.setItem("token", token);

    // now check firebase
    const user = await checkIfRegistered(token);

    if (!user) {
      await intiializeUser(token);
      navigate("/app/registration");
      return;
    }

    if (!user.init) {
      // indeed the user is real, but is the spoon? - Github Copilot, 2022
      navigate("/app/registration");
      return;
    }

    setUser(user);
  }, []);

  useEffect(() => {
    // fetch all the relevant stuff from the blockchain
    if (!user) return;

    setStarted(true);
  }, [user]);

  const handleFileChange = e => {
    const file = e.target.files[0];

    if (!file || !file.type || !file.type.startsWith("audio")) {
      alert("Please upload an audio file");
      e.target.files = null;
      inputRef.current.value = null;
      return;
    }

    const id = v4();
    const ref = firebase.storage().ref().child(`audio/${id}`);
    const event = ref.put(file);

    event.on(
      "state_changed",
      snapshot => {
        const progress =
          (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
        setUploading(snapshot.bytesTransferred / snapshot.totalBytes);
        console.log("Upload is " + progress + "% done");
      },
      error => {
        console.log(error);
      },
      () => {
        ref.getDownloadURL().then(url => {
          setFileUrl(url);
          console.log(url);
        });
      },
    );

    console.log(file);
  };

  const uploadSong = () => {
    const name = nameRef.current.value;
    const genre = selectedGenre.name;
    const file = fileUrl;
    const token = window.localStorage.getItem("token");

    if (!name || !genre || !file) {
      alert("Please fill out all the fields");
      return;
    }

    firebase
      .firestore()
      .collection("songs")
      .add({
        name,
        genre,
        fileUrl: file,
        authorId: token,
        createdAt: new Date(),
        author: user,
      })
      .then(res => {
        console.log(res);
        navigate("/app/song/" + res.id);
      })
      .catch(err => alert(err));
  };

  return started ? (
    <>
      <div className="min-h-full">
        <Popover as="header" className="pb-24 bg-gray-900">
          {({ open }) => (
            <>
              <div className="max-w-3xl mx-auto px-4 sm:px-6 lg:max-w-7xl lg:px-8">
                <div className="relative py-5 flex items-center justify-center lg:justify-between">
                  {/* Logo */}
                  <div className="absolute left-0 flex-shrink-0 lg:static">
                    <a href="#">
                      <span className="sr-only">Workflow</span>
                      <img
                        className="h-8 w-auto"
                        src="https://tailwindui.com/img/logos/workflow-mark-indigo-300.svg"
                        alt="Workflow"
                      />
                    </a>
                  </div>

                  {/* Right section on desktop */}
                  <div className="hidden lg:ml-4 lg:flex lg:items-center lg:pr-0.5">
                    {/* Profile dropdown */}
                    <Menu as="div" className="ml-4 relative flex-shrink-0">
                      <div>
                        <Menu.Button className="bg-white rounded-full flex text-sm ring-2 ring-white ring-opacity-20 focus:outline-none focus:ring-opacity-100">
                          <span className="sr-only">Open user menu</span>
                          <img
                            className="h-8 w-8 rounded-full"
                            src={user.profilePic}
                            alt=""
                          />
                        </Menu.Button>
                      </div>
                      <Transition
                        as={Fragment}
                        leave="transition ease-in duration-75"
                        leaveFrom="transform opacity-100 scale-100"
                        leaveTo="transform opacity-0 scale-95"
                      >
                        <Menu.Items className="origin-top-right z-40 absolute -right-2 mt-2 w-48 rounded-md shadow-lg py-1 bg-white ring-1 ring-black ring-opacity-5 focus:outline-none">
                          {userNavigation.map(item => (
                            <Menu.Item key={item.name}>
                              {({ active }) => (
                                <a
                                  href={item.href}
                                  className={classNames(
                                    active ? "bg-gray-100" : "",
                                    "block px-4 py-2 text-sm text-gray-700",
                                  )}
                                >
                                  {item.name}
                                </a>
                              )}
                            </Menu.Item>
                          ))}
                        </Menu.Items>
                      </Transition>
                    </Menu>
                  </div>

                  {/* Search */}
                  <div className="flex-1 min-w-0 px-12 lg:hidden">
                    <div className="max-w-xs w-full mx-auto">
                      <label htmlFor="desktop-search" className="sr-only">
                        Search
                      </label>
                      <div className="relative text-white focus-within:text-gray-600">
                        <div className="pointer-events-none absolute inset-y-0 left-0 pl-3 flex items-center">
                          <SearchIcon className="h-5 w-5" aria-hidden="true" />
                        </div>
                        <input
                          id="desktop-search"
                          className="block w-full bg-white bg-opacity-20 py-2 pl-10 pr-3 border border-transparent rounded-md leading-5 text-gray-900 placeholder-white focus:outline-none focus:bg-opacity-100 focus:border-transparent focus:placeholder-gray-500 focus:ring-0 sm:text-sm"
                          placeholder="Search"
                          type="search"
                          name="search"
                        />
                      </div>
                    </div>
                  </div>

                  {/* Menu button */}
                  <div className="absolute right-0 flex-shrink-0 lg:hidden">
                    {/* Mobile menu button */}
                    <Popover.Button className="bg-transparent p-2 rounded-md inline-flex items-center justify-center text-indigo-200 hover:text-white hover:bg-white hover:bg-opacity-10 focus:outline-none focus:ring-2 focus:ring-white">
                      <span className="sr-only">Open main menu</span>
                      {open ? (
                        <XIcon className="block h-6 w-6" aria-hidden="true" />
                      ) : (
                        <MenuIcon
                          className="block h-6 w-6"
                          aria-hidden="true"
                        />
                      )}
                    </Popover.Button>
                  </div>
                </div>
                <div className="hidden lg:block border-t border-white border-opacity-20 py-5">
                  <div className="grid grid-cols-3 gap-8 items-center">
                    <div className="col-span-2">
                      <nav className="flex space-x-4">
                        {navigation.map(item => (
                          <a
                            key={item.name}
                            href={item.href}
                            className={classNames(
                              item.current ? "text-white" : "text-indigo-100",
                              "text-sm font-medium rounded-md bg-white bg-opacity-0 px-3 py-2 hover:bg-opacity-10",
                            )}
                            aria-current={item.current ? "page" : undefined}
                          >
                            {item.name}
                          </a>
                        ))}
                      </nav>
                    </div>
                    <div>
                      <div className="max-w-md w-full mx-auto">
                        <label htmlFor="mobile-search" className="sr-only">
                          Search
                        </label>
                        <div className="relative text-white focus-within:text-gray-600">
                          <div className="pointer-events-none absolute inset-y-0 left-0 pl-3 flex items-center">
                            <SearchIcon
                              className="h-5 w-5"
                              aria-hidden="true"
                            />
                          </div>
                          <input
                            id="mobile-search"
                            className="block w-full bg-white bg-opacity-20 py-2 pl-10 pr-3 border border-transparent rounded-md leading-5 text-gray-900 placeholder-white focus:outline-none focus:bg-opacity-100 focus:border-transparent focus:placeholder-gray-500 focus:ring-0 sm:text-sm"
                            placeholder="Search"
                            type="search"
                            name="search"
                          />
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <Transition.Root as={Fragment}>
                <div className="lg:hidden">
                  <Transition.Child
                    as={Fragment}
                    enter="duration-150 ease-out"
                    enterFrom="opacity-0"
                    enterTo="opacity-100"
                    leave="duration-150 ease-in"
                    leaveFrom="opacity-100"
                    leaveTo="opacity-0"
                  >
                    <Popover.Overlay className="z-20 fixed inset-0 bg-black bg-opacity-25" />
                  </Transition.Child>

                  <Transition.Child
                    as={Fragment}
                    enter="duration-150 ease-out"
                    enterFrom="opacity-0 scale-95"
                    enterTo="opacity-100 scale-100"
                    leave="duration-150 ease-in"
                    leaveFrom="opacity-100 scale-100"
                    leaveTo="opacity-0 scale-95"
                  >
                    <Popover.Panel
                      focus
                      className="z-30 absolute top-0 inset-x-0 max-w-3xl mx-auto w-full p-2 transition transform origin-top"
                    >
                      <div className="rounded-lg shadow-lg ring-1 ring-black ring-opacity-5 bg-white divide-y divide-gray-200">
                        <div className="pt-3 pb-2">
                          <div className="flex items-center justify-between px-4">
                            <div>
                              <img
                                className="h-8 w-auto"
                                src="https://tailwindui.com/img/logos/workflow-mark-indigo-600.svg"
                                alt="Workflow"
                              />
                            </div>
                            <div className="-mr-2">
                              <Popover.Button className="bg-white rounded-md p-2 inline-flex items-center justify-center text-gray-400 hover:text-gray-500 hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-indigo-500">
                                <span className="sr-only">Close menu</span>
                                <XIcon className="h-6 w-6" aria-hidden="true" />
                              </Popover.Button>
                            </div>
                          </div>
                          <div className="mt-3 px-2 space-y-1">
                            {navigation.map((nav, key) => (
                              <a
                                href={nav.href}
                                className="block rounded-md px-3 py-2 text-base text-gray-900 font-medium hover:bg-gray-100 hover:text-gray-800"
                                key={key}
                              >
                                {nav.name}
                              </a>
                            ))}
                          </div>
                        </div>
                        <div className="pt-4 pb-2">
                          <div className="flex items-center px-5">
                            <div className="flex-shrink-0">
                              <img
                                className="h-10 w-10 rounded-full"
                                src={user.profilePic}
                                alt=""
                              />
                            </div>
                            <div className="ml-3 min-w-0 flex-1">
                              <div className="text-base font-medium text-gray-800 truncate">
                                {user.name}
                              </div>
                              <div className="text-sm font-medium text-gray-500 truncate">
                                {user.email}
                              </div>
                            </div>
                            <button
                              type="button"
                              className="ml-auto flex-shrink-0 bg-white p-1 text-gray-400 rounded-full hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                            >
                              <span className="sr-only">
                                View notifications
                              </span>
                              <BellIcon
                                className="h-6 w-6"
                                aria-hidden="true"
                              />
                            </button>
                          </div>
                          <div className="mt-3 px-2 space-y-1">
                            {userNavigation.map(item => (
                              <a
                                key={item.name}
                                href={item.href}
                                className="block rounded-md px-3 py-2 text-base text-gray-900 font-medium hover:bg-gray-100 hover:text-gray-800"
                              >
                                {item.name}
                              </a>
                            ))}
                          </div>
                        </div>
                      </div>
                    </Popover.Panel>
                  </Transition.Child>
                </div>
              </Transition.Root>
            </>
          )}
        </Popover>
        <main className="-mt-24 pb-8 ">
          <div className="max-w-3xl mx-auto px-4 sm:px-6 lg:max-w-7xl lg:px-8">
            <h1 className="sr-only">Page title</h1>
            {/* Main 3 column grid */}
            <div className="grid grid-cols-1 gap-4 items-start lg:grid-cols-3 lg:gap-8">
              {/* Left column */}

              {/* Right column */}
              <div className="grid grid-cols-1 lg:col-span-4 justify-center">
                <section
                  aria-labelledby="section-1-title"
                  className="justify-center"
                >
                  <h2 className="sr-only" id="section-1-title">
                    Create a song
                  </h2>
                  <div className="rounded-lg bg-white overflow-hidden shadow justify-center mx-auto">
                    <div className="p-6 " style={{ minHeight: "500px" }}>
                      <h1 className="text-2xl font-bold">Add a song</h1>
                      <div className="max-w-md mt-5">
                        <label
                          htmlFor="email"
                          className="block text-sm font-medium text-gray-700"
                        >
                          What's the name of your song?
                        </label>
                        <div className="mt-1">
                          <input
                            type="email"
                            name="email"
                            ref={nameRef}
                            id="email"
                            className="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"
                            placeholder="eg. qoobes' shuffle truffle"
                          />
                        </div>
                      </div>

                      <div className="max-w-md mt-5">
                        <label
                          htmlFor="email"
                          className="block text-sm font-medium text-gray-700"
                        >
                          What's your song's genre?
                        </label>
                        <div className="mt-1">
                          <Dropdown
                            options={genres}
                            selected={selectedGenre}
                            setSelected={setSelectedGenre}
                          />
                        </div>
                      </div>
                      <div className="max-w-md mt-5">
                        <label
                          htmlFor="email"
                          className="block text-sm font-medium text-gray-700"
                        >
                          Upload your song
                        </label>
                        {!uploading ? (
                          <div className="mt-1">
                            <input
                              type="file"
                              className="hidden"
                              onChange={handleFileChange}
                              ref={inputRef}
                            />
                            <button
                              onClick={() => inputRef.current.click()}
                              type="button"
                              className="inline-flex items-center px-2.5 py-1.5 border border-transparent text-xs font-medium rounded text-indigo-700 bg-indigo-100 hover:bg-indigo-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                            >
                              Choose a file
                            </button>
                          </div>
                        ) : uploading === 1 ? (
                          <div className="mt-1">
                            <div className="w-md relative items-center py-1.5 border border-transparent text-sm font-medium rounded text-indigo-700 bg-white focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                              Song Sucessfully Uploaded ✅
                            </div>
                          </div>
                        ) : (
                          <div className="mt-1">
                            <div className="w-md relative items-center px-2.5 py-1.5 border border-transparent text-xs font-medium rounded text-indigo-700 bg-indigo-100 hover:bg-indigo-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                              <div
                                className="absolute left-0 top-0 h-full bg-indigo-300 z-10 transition-all duration-1000"
                                style={{ width: `${uploading * 100}%` }}
                              />
                            </div>
                          </div>
                        )}
                        <button
                          type="button"
                          className=" mt-3 inline-flex items-center px-4 py-1 font-semibold leading-6 text-sm shadow rounded-md text-white bg-indigo-500 hover:bg-indigo-400 transition ease-in-out duration-150 "
                          onClick={uploadSong}
                        >
                          Publish your song
                        </button>
                      </div>
                    </div>
                  </div>
                </section>
              </div>
            </div>
          </div>
        </main>
        <footer>
          <div className="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8 lg:max-w-7xl">
            <div className="border-t border-gray-200 py-8 text-sm text-gray-500 text-center sm:text-left">
              <span className="block sm:inline">&copy; 2022 Cantio.</span>{" "}
              <span className="block sm:inline">All rights reserved.</span>
            </div>
          </div>
        </footer>
      </div>
    </>
  ) : (
    <div
      className="w-full flex justify-center items-center flex-col"
      style={{ height: "85vh" }}
    >
      <TypeAnimation
        sequence={[
          "create music.",
          3000,
          "enjoy music.",
          3000,
          "support music.",
          3000,
          "love music.",
        ]}
        wrapper="span"
        className="pb-3 block bg-clip-text text-transparent bg-gradient-to-r from-teal-400 to-cyan-700 sm:pb-5 text-2xl mb-2 font-bold"
        repeat={3}
      />
      <button
        type="button"
        className="inline-flex items-center px-4 py-2 font-semibold leading-6 text-sm shadow rounded-md text-white bg-indigo-500 hover:bg-indigo-400 transition ease-in-out duration-150 cursor-not-allowed"
        disabled=""
      >
        <svg
          className="animate-spin -ml-1 mr-3 h-5 w-5 text-white"
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 24 24"
        >
          <circle
            className="opacity-25"
            cx="12"
            cy="12"
            r="10"
            stroke="currentColor"
            strokeWidth="4"
          ></circle>
          <path
            className="opacity-75"
            fill="currentColor"
            d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
          ></path>
        </svg>
        Loading the app, please wait...
      </button>
    </div>
  );
};

export default Create;
