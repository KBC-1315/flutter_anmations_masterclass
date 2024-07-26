'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/NOTICES": "ec0c467e0073671d67ca071f552bae0c",
"assets/AssetManifest.bin.json": "5fd8caeb1ac0fa52441749af0ed94a6a",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/assets/covers/%25ED%2595%259C%25ED%2599%2594.svg": "3233aec6b6f4e195a0bee87c2f5546c1",
"assets/assets/covers/KT.svg": "0c3ab28cd4ae73b4932c7c4ca5390398",
"assets/assets/covers/NC.svg": "b762e5cf444a6ff677341d9eba4bbf37",
"assets/assets/covers/%25ED%2582%25A4%25EC%259B%2580.svg": "581b1a152ee2d5b867c6ddddb8574013",
"assets/assets/covers/1.png": "45ebb8e801faf426c326b75177f56f14",
"assets/assets/covers/%25EB%25A1%25AF%25EB%258D%25B0.svg": "851b81d4185e03c293e3ce04e8479d42",
"assets/assets/covers/SSG_%25EB%259E%259C%25EB%258D%2594%25EC%258A%25A4.svg": "0d16b25af44006c3cc305fc568c63069",
"assets/assets/covers/KIA.svg": "1808698d7b42ed68c69cbe38cf066ee2",
"assets/assets/covers/2.png": "b898214d9b313a6ce72dcfaaea37718f",
"assets/assets/covers/%25EC%2582%25BC%25EC%2584%25B1.svg": "df7e1eaf1bca87aa30b5e36a5e29af06",
"assets/assets/covers/4.png": "26d429c8200865ec46148bdbd6c0f6d1",
"assets/assets/covers/LG.svg": "62a3a55c250925ba019367549d698572",
"assets/assets/covers/3.png": "f0c48ab0bdf217f9212bb4a8af9321bc",
"assets/assets/covers/%25EB%2591%2590%25EC%2582%25B0.svg": "5fc4ebc03087c52339ea00c15bfa6a68",
"assets/assets/covers/5.png": "f70be8e8850bae22c095fcace5f6dcd9",
"assets/fonts/MaterialIcons-Regular.otf": "d715adfc483b366b91c66e3951e9e559",
"assets/AssetManifest.json": "f6933713f55874ee9c8a4f732cd4b065",
"assets/AssetManifest.bin": "5d7b0a41384d98608cc784ee5fa95dd4",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"index.html": "4a315bae78e273a6d8c4db440f2e5019",
"/": "4a315bae78e273a6d8c4db440f2e5019",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"canvaskit/canvaskit.wasm": "a7401f1c3c2f6f3718f70fff9c560a42",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "3ec4bbdc434e7b9a383c0e75f7d78e0a",
"canvaskit/skwasm.wasm": "0e79dd7cccb9e1496313eeffffc3a6b9",
"canvaskit/skwasm.js.symbols": "7d1398dbd4d1108173353c711b3ccc0b",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/chromium/canvaskit.wasm": "f68f58a2d4f0a4c138b1f3dad9b886c3",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "1f641ad3fedc36384060186a9a42a3e5",
"flutter_bootstrap.js": "9115f65bd36b79bff39dd7ed4555320c",
"main.dart.js": "26711c9bc3e779c9ceb85b0b24d30890",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"manifest.json": "aaf27bc2d35b81e1fa70061600ed7e45",
"version.json": "5ed13d9e861ad036646b4436fef2a38e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
