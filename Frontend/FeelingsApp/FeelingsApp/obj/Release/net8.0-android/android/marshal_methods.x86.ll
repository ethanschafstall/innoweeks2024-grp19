; ModuleID = 'marshal_methods.x86.ll'
source_filename = "marshal_methods.x86.ll"
target datalayout = "e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i686-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [175 x ptr] zeroinitializer, align 4

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [350 x i32] [
	i32 2616222, ; 0: System.Net.NetworkInformation.dll => 0x27eb9e => 119
	i32 10166715, ; 1: System.Net.NameResolution.dll => 0x9b21bb => 118
	i32 15721112, ; 2: System.Runtime.Intrinsics.dll => 0xefe298 => 140
	i32 39109920, ; 3: Newtonsoft.Json.dll => 0x254c520 => 54
	i32 42639949, ; 4: System.Threading.Thread => 0x28aa24d => 162
	i32 67008169, ; 5: zh-Hant\Microsoft.Maui.Controls.resources => 0x3fe76a9 => 33
	i32 68219467, ; 6: System.Security.Cryptography.Primitives => 0x410f24b => 151
	i32 72070932, ; 7: Microsoft.Maui.Graphics.dll => 0x44bb714 => 52
	i32 117431740, ; 8: System.Runtime.InteropServices => 0x6ffddbc => 139
	i32 122350210, ; 9: System.Threading.Channels.dll => 0x74aea82 => 161
	i32 142721839, ; 10: System.Net.WebHeaderCollection => 0x881c32f => 126
	i32 149972175, ; 11: System.Security.Cryptography.Primitives.dll => 0x8f064cf => 151
	i32 165246403, ; 12: Xamarin.AndroidX.Collection.dll => 0x9d975c3 => 64
	i32 182336117, ; 13: Xamarin.AndroidX.SwipeRefreshLayout.dll => 0xade3a75 => 83
	i32 195452805, ; 14: vi/Microsoft.Maui.Controls.resources.dll => 0xba65f85 => 30
	i32 199333315, ; 15: zh-HK/Microsoft.Maui.Controls.resources.dll => 0xbe195c3 => 31
	i32 205061960, ; 16: System.ComponentModel => 0xc38ff48 => 101
	i32 230752869, ; 17: Microsoft.CSharp.dll => 0xdc10265 => 92
	i32 246610117, ; 18: System.Reflection.Emit.Lightweight => 0xeb2f8c5 => 133
	i32 280992041, ; 19: cs/Microsoft.Maui.Controls.resources.dll => 0x10bf9929 => 2
	i32 317674968, ; 20: vi\Microsoft.Maui.Controls.resources => 0x12ef55d8 => 30
	i32 318968648, ; 21: Xamarin.AndroidX.Activity.dll => 0x13031348 => 60
	i32 336156722, ; 22: ja/Microsoft.Maui.Controls.resources.dll => 0x14095832 => 15
	i32 342366114, ; 23: Xamarin.AndroidX.Lifecycle.Common => 0x146817a2 => 71
	i32 356389973, ; 24: it/Microsoft.Maui.Controls.resources.dll => 0x153e1455 => 14
	i32 374914964, ; 25: System.Transactions.Local => 0x1658bf94 => 165
	i32 375677976, ; 26: System.Net.ServicePoint.dll => 0x16646418 => 123
	i32 379916513, ; 27: System.Threading.Thread.dll => 0x16a510e1 => 162
	i32 385762202, ; 28: System.Memory.dll => 0x16fe439a => 115
	i32 392610295, ; 29: System.Threading.ThreadPool.dll => 0x1766c1f7 => 163
	i32 395744057, ; 30: _Microsoft.Android.Resource.Designer => 0x17969339 => 34
	i32 435591531, ; 31: sv/Microsoft.Maui.Controls.resources.dll => 0x19f6996b => 26
	i32 442565967, ; 32: System.Collections => 0x1a61054f => 97
	i32 450948140, ; 33: Xamarin.AndroidX.Fragment.dll => 0x1ae0ec2c => 70
	i32 451504562, ; 34: System.Security.Cryptography.X509Certificates => 0x1ae969b2 => 152
	i32 459347974, ; 35: System.Runtime.Serialization.Primitives.dll => 0x1b611806 => 144
	i32 469710990, ; 36: System.dll => 0x1bff388e => 169
	i32 498788369, ; 37: System.ObjectModel => 0x1dbae811 => 128
	i32 500358224, ; 38: id/Microsoft.Maui.Controls.resources.dll => 0x1dd2dc50 => 13
	i32 503918385, ; 39: fi/Microsoft.Maui.Controls.resources.dll => 0x1e092f31 => 7
	i32 513247710, ; 40: Microsoft.Extensions.Primitives.dll => 0x1e9789de => 47
	i32 539058512, ; 41: Microsoft.Extensions.Logging => 0x20216150 => 44
	i32 540030774, ; 42: System.IO.FileSystem.dll => 0x20303736 => 112
	i32 545304856, ; 43: System.Runtime.Extensions => 0x2080b118 => 137
	i32 592146354, ; 44: pt-BR/Microsoft.Maui.Controls.resources.dll => 0x234b6fb2 => 21
	i32 613668793, ; 45: System.Security.Cryptography.Algorithms => 0x2493d7b9 => 148
	i32 618636221, ; 46: K4os.Compression.LZ4.Streams => 0x24dfa3bd => 38
	i32 619495927, ; 47: FeelingsApp.dll => 0x24ecc1f7 => 91
	i32 627609679, ; 48: Xamarin.AndroidX.CustomView => 0x2568904f => 68
	i32 627931235, ; 49: nl\Microsoft.Maui.Controls.resources => 0x256d7863 => 19
	i32 662205335, ; 50: System.Text.Encodings.Web.dll => 0x27787397 => 158
	i32 672442732, ; 51: System.Collections.Concurrent => 0x2814a96c => 94
	i32 683518922, ; 52: System.Net.Security => 0x28bdabca => 122
	i32 688181140, ; 53: ca/Microsoft.Maui.Controls.resources.dll => 0x2904cf94 => 1
	i32 690569205, ; 54: System.Xml.Linq.dll => 0x29293ff5 => 166
	i32 706645707, ; 55: ko/Microsoft.Maui.Controls.resources.dll => 0x2a1e8ecb => 16
	i32 709557578, ; 56: de/Microsoft.Maui.Controls.resources.dll => 0x2a4afd4a => 4
	i32 722857257, ; 57: System.Runtime.Loader.dll => 0x2b15ed29 => 141
	i32 734693584, ; 58: FeelingsApp => 0x2bca88d0 => 91
	i32 759454413, ; 59: System.Net.Requests => 0x2d445acd => 121
	i32 775507847, ; 60: System.IO.Compression => 0x2e394f87 => 111
	i32 777317022, ; 61: sk\Microsoft.Maui.Controls.resources => 0x2e54ea9e => 25
	i32 789151979, ; 62: Microsoft.Extensions.Options => 0x2f0980eb => 46
	i32 804715423, ; 63: System.Data.Common => 0x2ff6fb9f => 103
	i32 809851609, ; 64: System.Drawing.Common.dll => 0x30455ad9 => 56
	i32 823281589, ; 65: System.Private.Uri.dll => 0x311247b5 => 129
	i32 830298997, ; 66: System.IO.Compression.Brotli => 0x317d5b75 => 110
	i32 878954865, ; 67: System.Net.Http.Json => 0x3463c971 => 116
	i32 904024072, ; 68: System.ComponentModel.Primitives.dll => 0x35e25008 => 99
	i32 926902833, ; 69: tr/Microsoft.Maui.Controls.resources.dll => 0x373f6a31 => 28
	i32 955402788, ; 70: Newtonsoft.Json => 0x38f24a24 => 54
	i32 966729478, ; 71: Xamarin.Google.Crypto.Tink.Android => 0x399f1f06 => 87
	i32 967690846, ; 72: Xamarin.AndroidX.Lifecycle.Common.dll => 0x39adca5e => 71
	i32 975874589, ; 73: System.Xml.XDocument => 0x3a2aaa1d => 168
	i32 983077409, ; 74: MySql.Data.dll => 0x3a989221 => 53
	i32 992768348, ; 75: System.Collections.dll => 0x3b2c715c => 97
	i32 994442037, ; 76: System.IO.FileSystem => 0x3b45fb35 => 112
	i32 1012816738, ; 77: Xamarin.AndroidX.SavedState.dll => 0x3c5e5b62 => 81
	i32 1019214401, ; 78: System.Drawing => 0x3cbffa41 => 108
	i32 1028951442, ; 79: Microsoft.Extensions.DependencyInjection.Abstractions => 0x3d548d92 => 43
	i32 1029334545, ; 80: da/Microsoft.Maui.Controls.resources.dll => 0x3d5a6611 => 3
	i32 1035644815, ; 81: Xamarin.AndroidX.AppCompat => 0x3dbaaf8f => 61
	i32 1036536393, ; 82: System.Drawing.Primitives.dll => 0x3dc84a49 => 107
	i32 1044663988, ; 83: System.Linq.Expressions.dll => 0x3e444eb4 => 113
	i32 1052210849, ; 84: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 0x3eb776a1 => 73
	i32 1082857460, ; 85: System.ComponentModel.TypeConverter => 0x408b17f4 => 100
	i32 1084122840, ; 86: Xamarin.Kotlin.StdLib => 0x409e66d8 => 88
	i32 1098259244, ; 87: System => 0x41761b2c => 169
	i32 1118262833, ; 88: ko\Microsoft.Maui.Controls.resources => 0x42a75631 => 16
	i32 1145483052, ; 89: System.Windows.Extensions.dll => 0x4446af2c => 59
	i32 1168523401, ; 90: pt\Microsoft.Maui.Controls.resources => 0x45a64089 => 22
	i32 1178241025, ; 91: Xamarin.AndroidX.Navigation.Runtime.dll => 0x463a8801 => 78
	i32 1203215381, ; 92: pl/Microsoft.Maui.Controls.resources.dll => 0x47b79c15 => 20
	i32 1208641965, ; 93: System.Diagnostics.Process => 0x480a69ad => 105
	i32 1234928153, ; 94: nb/Microsoft.Maui.Controls.resources.dll => 0x499b8219 => 18
	i32 1260983243, ; 95: cs\Microsoft.Maui.Controls.resources => 0x4b2913cb => 2
	i32 1293217323, ; 96: Xamarin.AndroidX.DrawerLayout.dll => 0x4d14ee2b => 69
	i32 1324164729, ; 97: System.Linq => 0x4eed2679 => 114
	i32 1373134921, ; 98: zh-Hans\Microsoft.Maui.Controls.resources => 0x51d86049 => 32
	i32 1376866003, ; 99: Xamarin.AndroidX.SavedState => 0x52114ed3 => 81
	i32 1379779777, ; 100: System.Resources.ResourceManager => 0x523dc4c1 => 135
	i32 1406073936, ; 101: Xamarin.AndroidX.CoordinatorLayout => 0x53cefc50 => 65
	i32 1408764838, ; 102: System.Runtime.Serialization.Formatters.dll => 0x53f80ba6 => 143
	i32 1411638395, ; 103: System.Runtime.CompilerServices.Unsafe => 0x5423e47b => 136
	i32 1430672901, ; 104: ar\Microsoft.Maui.Controls.resources => 0x55465605 => 0
	i32 1435222561, ; 105: Xamarin.Google.Crypto.Tink.Android.dll => 0x558bc221 => 87
	i32 1452070440, ; 106: System.Formats.Asn1.dll => 0x568cd628 => 109
	i32 1457743152, ; 107: System.Runtime.Extensions.dll => 0x56e36530 => 137
	i32 1458022317, ; 108: System.Net.Security.dll => 0x56e7a7ad => 122
	i32 1461004990, ; 109: es\Microsoft.Maui.Controls.resources => 0x57152abe => 6
	i32 1462112819, ; 110: System.IO.Compression.dll => 0x57261233 => 111
	i32 1469204771, ; 111: Xamarin.AndroidX.AppCompat.AppCompatResources => 0x57924923 => 62
	i32 1470490898, ; 112: Microsoft.Extensions.Primitives => 0x57a5e912 => 47
	i32 1480492111, ; 113: System.IO.Compression.Brotli.dll => 0x583e844f => 110
	i32 1487239319, ; 114: Microsoft.Win32.Primitives => 0x58a57897 => 93
	i32 1487250139, ; 115: K4os.Hash.xxHash => 0x58a5a2db => 39
	i32 1493001747, ; 116: hi/Microsoft.Maui.Controls.resources.dll => 0x58fd6613 => 10
	i32 1514721132, ; 117: el/Microsoft.Maui.Controls.resources.dll => 0x5a48cf6c => 5
	i32 1543031311, ; 118: System.Text.RegularExpressions.dll => 0x5bf8ca0f => 160
	i32 1551623176, ; 119: sk/Microsoft.Maui.Controls.resources.dll => 0x5c7be408 => 25
	i32 1604827217, ; 120: System.Net.WebClient => 0x5fa7b851 => 125
	i32 1622152042, ; 121: Xamarin.AndroidX.Loader.dll => 0x60b0136a => 75
	i32 1624863272, ; 122: Xamarin.AndroidX.ViewPager2 => 0x60d97228 => 85
	i32 1636350590, ; 123: Xamarin.AndroidX.CursorAdapter => 0x6188ba7e => 67
	i32 1639515021, ; 124: System.Net.Http.dll => 0x61b9038d => 117
	i32 1639986890, ; 125: System.Text.RegularExpressions => 0x61c036ca => 160
	i32 1641389582, ; 126: System.ComponentModel.EventBasedAsync.dll => 0x61d59e0e => 98
	i32 1657153582, ; 127: System.Runtime => 0x62c6282e => 145
	i32 1658251792, ; 128: Xamarin.Google.Android.Material.dll => 0x62d6ea10 => 86
	i32 1677501392, ; 129: System.Net.Primitives.dll => 0x63fca3d0 => 120
	i32 1679769178, ; 130: System.Security.Cryptography => 0x641f3e5a => 153
	i32 1696967625, ; 131: System.Security.Cryptography.Csp => 0x6525abc9 => 149
	i32 1729485958, ; 132: Xamarin.AndroidX.CardView.dll => 0x6715dc86 => 63
	i32 1736233607, ; 133: ro/Microsoft.Maui.Controls.resources.dll => 0x677cd287 => 23
	i32 1743415430, ; 134: ca\Microsoft.Maui.Controls.resources => 0x67ea6886 => 1
	i32 1744735666, ; 135: System.Transactions.Local.dll => 0x67fe8db2 => 165
	i32 1746115085, ; 136: System.IO.Pipelines.dll => 0x68139a0d => 57
	i32 1750313021, ; 137: Microsoft.Win32.Primitives.dll => 0x6853a83d => 93
	i32 1763938596, ; 138: System.Diagnostics.TraceSource.dll => 0x69239124 => 106
	i32 1766324549, ; 139: Xamarin.AndroidX.SwipeRefreshLayout => 0x6947f945 => 83
	i32 1770582343, ; 140: Microsoft.Extensions.Logging.dll => 0x6988f147 => 44
	i32 1780572499, ; 141: Mono.Android.Runtime.dll => 0x6a216153 => 173
	i32 1782862114, ; 142: ms\Microsoft.Maui.Controls.resources => 0x6a445122 => 17
	i32 1788241197, ; 143: Xamarin.AndroidX.Fragment => 0x6a96652d => 70
	i32 1793755602, ; 144: he\Microsoft.Maui.Controls.resources => 0x6aea89d2 => 9
	i32 1808609942, ; 145: Xamarin.AndroidX.Loader => 0x6bcd3296 => 75
	i32 1813058853, ; 146: Xamarin.Kotlin.StdLib.dll => 0x6c111525 => 88
	i32 1813201214, ; 147: Xamarin.Google.Android.Material => 0x6c13413e => 86
	i32 1818569960, ; 148: Xamarin.AndroidX.Navigation.UI.dll => 0x6c652ce8 => 79
	i32 1824175904, ; 149: System.Text.Encoding.Extensions => 0x6cbab720 => 157
	i32 1824722060, ; 150: System.Runtime.Serialization.Formatters => 0x6cc30c8c => 143
	i32 1828688058, ; 151: Microsoft.Extensions.Logging.Abstractions.dll => 0x6cff90ba => 45
	i32 1829150748, ; 152: System.Windows.Extensions => 0x6d06a01c => 59
	i32 1842015223, ; 153: uk/Microsoft.Maui.Controls.resources.dll => 0x6dcaebf7 => 29
	i32 1853025655, ; 154: sv\Microsoft.Maui.Controls.resources => 0x6e72ed77 => 26
	i32 1858542181, ; 155: System.Linq.Expressions => 0x6ec71a65 => 113
	i32 1870277092, ; 156: System.Reflection.Primitives => 0x6f7a29e4 => 134
	i32 1875935024, ; 157: fr\Microsoft.Maui.Controls.resources => 0x6fd07f30 => 8
	i32 1900610850, ; 158: System.Resources.ResourceManager.dll => 0x71490522 => 135
	i32 1910275211, ; 159: System.Collections.NonGeneric.dll => 0x71dc7c8b => 95
	i32 1925302748, ; 160: K4os.Compression.LZ4.dll => 0x72c1c9dc => 37
	i32 1939592360, ; 161: System.Private.Xml.Linq => 0x739bd4a8 => 130
	i32 1961813231, ; 162: Xamarin.AndroidX.Security.SecurityCrypto.dll => 0x74eee4ef => 82
	i32 1968388702, ; 163: Microsoft.Extensions.Configuration.dll => 0x75533a5e => 40
	i32 2003115576, ; 164: el\Microsoft.Maui.Controls.resources => 0x77651e38 => 5
	i32 2019465201, ; 165: Xamarin.AndroidX.Lifecycle.ViewModel => 0x785e97f1 => 73
	i32 2025202353, ; 166: ar/Microsoft.Maui.Controls.resources.dll => 0x78b622b1 => 0
	i32 2045470958, ; 167: System.Private.Xml => 0x79eb68ee => 131
	i32 2055257422, ; 168: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 0x7a80bd4e => 72
	i32 2066184531, ; 169: de\Microsoft.Maui.Controls.resources => 0x7b277953 => 4
	i32 2070888862, ; 170: System.Diagnostics.TraceSource => 0x7b6f419e => 106
	i32 2079903147, ; 171: System.Runtime.dll => 0x7bf8cdab => 145
	i32 2090596640, ; 172: System.Numerics.Vectors => 0x7c9bf920 => 127
	i32 2127167465, ; 173: System.Console => 0x7ec9ffe9 => 102
	i32 2142473426, ; 174: System.Collections.Specialized => 0x7fb38cd2 => 96
	i32 2159891885, ; 175: Microsoft.Maui => 0x80bd55ad => 50
	i32 2169148018, ; 176: hu\Microsoft.Maui.Controls.resources => 0x814a9272 => 12
	i32 2181898931, ; 177: Microsoft.Extensions.Options.dll => 0x820d22b3 => 46
	i32 2192057212, ; 178: Microsoft.Extensions.Logging.Abstractions => 0x82a8237c => 45
	i32 2193016926, ; 179: System.ObjectModel.dll => 0x82b6c85e => 128
	i32 2201107256, ; 180: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 0x83323b38 => 89
	i32 2201231467, ; 181: System.Net.Http => 0x8334206b => 117
	i32 2207618523, ; 182: it\Microsoft.Maui.Controls.resources => 0x839595db => 14
	i32 2265110946, ; 183: System.Security.AccessControl.dll => 0x8702d9a2 => 146
	i32 2266799131, ; 184: Microsoft.Extensions.Configuration.Abstractions => 0x871c9c1b => 41
	i32 2270573516, ; 185: fr/Microsoft.Maui.Controls.resources.dll => 0x875633cc => 8
	i32 2279755925, ; 186: Xamarin.AndroidX.RecyclerView.dll => 0x87e25095 => 80
	i32 2295906218, ; 187: System.Net.Sockets => 0x88d8bfaa => 124
	i32 2303942373, ; 188: nb\Microsoft.Maui.Controls.resources => 0x89535ee5 => 18
	i32 2305521784, ; 189: System.Private.CoreLib.dll => 0x896b7878 => 171
	i32 2340441535, ; 190: System.Runtime.InteropServices.RuntimeInformation.dll => 0x8b804dbf => 138
	i32 2353062107, ; 191: System.Net.Primitives => 0x8c40e0db => 120
	i32 2368005991, ; 192: System.Xml.ReaderWriter.dll => 0x8d24e767 => 167
	i32 2371007202, ; 193: Microsoft.Extensions.Configuration => 0x8d52b2e2 => 40
	i32 2378619854, ; 194: System.Security.Cryptography.Csp.dll => 0x8dc6dbce => 149
	i32 2383496789, ; 195: System.Security.Principal.Windows.dll => 0x8e114655 => 154
	i32 2395872292, ; 196: id\Microsoft.Maui.Controls.resources => 0x8ece1c24 => 13
	i32 2427813419, ; 197: hi\Microsoft.Maui.Controls.resources => 0x90b57e2b => 10
	i32 2435356389, ; 198: System.Console.dll => 0x912896e5 => 102
	i32 2458678730, ; 199: System.Net.Sockets.dll => 0x928c75ca => 124
	i32 2471841756, ; 200: netstandard.dll => 0x93554fdc => 170
	i32 2475788418, ; 201: Java.Interop.dll => 0x93918882 => 172
	i32 2480646305, ; 202: Microsoft.Maui.Controls => 0x93dba8a1 => 48
	i32 2483903535, ; 203: System.ComponentModel.EventBasedAsync => 0x940d5c2f => 98
	i32 2484371297, ; 204: System.Net.ServicePoint => 0x94147f61 => 123
	i32 2486824558, ; 205: K4os.Hash.xxHash.dll => 0x9439ee6e => 39
	i32 2498657740, ; 206: BouncyCastle.Cryptography.dll => 0x94ee7dcc => 35
	i32 2538310050, ; 207: System.Reflection.Emit.Lightweight.dll => 0x974b89a2 => 133
	i32 2550873716, ; 208: hr\Microsoft.Maui.Controls.resources => 0x980b3e74 => 11
	i32 2562349572, ; 209: Microsoft.CSharp => 0x98ba5a04 => 92
	i32 2570120770, ; 210: System.Text.Encodings.Web => 0x9930ee42 => 158
	i32 2585220780, ; 211: System.Text.Encoding.Extensions.dll => 0x9a1756ac => 157
	i32 2589602615, ; 212: System.Threading.ThreadPool => 0x9a5a3337 => 163
	i32 2593496499, ; 213: pl\Microsoft.Maui.Controls.resources => 0x9a959db3 => 20
	i32 2605712449, ; 214: Xamarin.KotlinX.Coroutines.Core.Jvm => 0x9b500441 => 89
	i32 2611359322, ; 215: ZstdSharp.dll => 0x9ba62e5a => 90
	i32 2617129537, ; 216: System.Private.Xml.dll => 0x9bfe3a41 => 131
	i32 2620871830, ; 217: Xamarin.AndroidX.CursorAdapter.dll => 0x9c375496 => 67
	i32 2626831493, ; 218: ja\Microsoft.Maui.Controls.resources => 0x9c924485 => 15
	i32 2663698177, ; 219: System.Runtime.Loader => 0x9ec4cf01 => 141
	i32 2664396074, ; 220: System.Xml.XDocument.dll => 0x9ecf752a => 168
	i32 2665622720, ; 221: System.Drawing.Primitives => 0x9ee22cc0 => 107
	i32 2676780864, ; 222: System.Data.Common.dll => 0x9f8c6f40 => 103
	i32 2717744543, ; 223: System.Security.Claims => 0xa1fd7d9f => 147
	i32 2724373263, ; 224: System.Runtime.Numerics.dll => 0xa262a30f => 142
	i32 2732626843, ; 225: Xamarin.AndroidX.Activity => 0xa2e0939b => 60
	i32 2735172069, ; 226: System.Threading.Channels => 0xa30769e5 => 161
	i32 2737747696, ; 227: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 0xa32eb6f0 => 62
	i32 2752995522, ; 228: pt-BR\Microsoft.Maui.Controls.resources => 0xa41760c2 => 21
	i32 2758225723, ; 229: Microsoft.Maui.Controls.Xaml => 0xa4672f3b => 49
	i32 2764765095, ; 230: Microsoft.Maui.dll => 0xa4caf7a7 => 50
	i32 2765824710, ; 231: System.Text.Encoding.CodePages.dll => 0xa4db22c6 => 156
	i32 2778768386, ; 232: Xamarin.AndroidX.ViewPager.dll => 0xa5a0a402 => 84
	i32 2785988530, ; 233: th\Microsoft.Maui.Controls.resources => 0xa60ecfb2 => 27
	i32 2801831435, ; 234: Microsoft.Maui.Graphics => 0xa7008e0b => 52
	i32 2806116107, ; 235: es/Microsoft.Maui.Controls.resources.dll => 0xa741ef0b => 6
	i32 2810250172, ; 236: Xamarin.AndroidX.CoordinatorLayout.dll => 0xa78103bc => 65
	i32 2831556043, ; 237: nl/Microsoft.Maui.Controls.resources.dll => 0xa8c61dcb => 19
	i32 2841355853, ; 238: System.Security.Permissions => 0xa95ba64d => 58
	i32 2853208004, ; 239: Xamarin.AndroidX.ViewPager => 0xaa107fc4 => 84
	i32 2861189240, ; 240: Microsoft.Maui.Essentials => 0xaa8a4878 => 51
	i32 2909740682, ; 241: System.Private.CoreLib => 0xad6f1e8a => 171
	i32 2916838712, ; 242: Xamarin.AndroidX.ViewPager2.dll => 0xaddb6d38 => 85
	i32 2919462931, ; 243: System.Numerics.Vectors.dll => 0xae037813 => 127
	i32 2944313911, ; 244: System.Configuration.ConfigurationManager.dll => 0xaf7eaa37 => 55
	i32 2959614098, ; 245: System.ComponentModel.dll => 0xb0682092 => 101
	i32 2968338931, ; 246: System.Security.Principal.Windows => 0xb0ed41f3 => 154
	i32 2972252294, ; 247: System.Security.Cryptography.Algorithms.dll => 0xb128f886 => 148
	i32 2978675010, ; 248: Xamarin.AndroidX.DrawerLayout => 0xb18af942 => 69
	i32 2987532451, ; 249: Xamarin.AndroidX.Security.SecurityCrypto => 0xb21220a3 => 82
	i32 3012788804, ; 250: System.Configuration.ConfigurationManager => 0xb3938244 => 55
	i32 3025069135, ; 251: K4os.Compression.LZ4.Streams.dll => 0xb44ee44f => 38
	i32 3038032645, ; 252: _Microsoft.Android.Resource.Designer.dll => 0xb514b305 => 34
	i32 3057625584, ; 253: Xamarin.AndroidX.Navigation.Common => 0xb63fa9f0 => 76
	i32 3059408633, ; 254: Mono.Android.Runtime => 0xb65adef9 => 173
	i32 3059793426, ; 255: System.ComponentModel.Primitives => 0xb660be12 => 99
	i32 3077302341, ; 256: hu/Microsoft.Maui.Controls.resources.dll => 0xb76be845 => 12
	i32 3089219899, ; 257: ZstdSharp => 0xb821c13b => 90
	i32 3090735792, ; 258: System.Security.Cryptography.X509Certificates.dll => 0xb838e2b0 => 152
	i32 3099732863, ; 259: System.Security.Claims.dll => 0xb8c22b7f => 147
	i32 3103600923, ; 260: System.Formats.Asn1 => 0xb8fd311b => 109
	i32 3132293585, ; 261: System.Security.AccessControl => 0xbab301d1 => 146
	i32 3159123045, ; 262: System.Reflection.Primitives.dll => 0xbc4c6465 => 134
	i32 3178803400, ; 263: Xamarin.AndroidX.Navigation.Fragment.dll => 0xbd78b0c8 => 77
	i32 3213246214, ; 264: System.Security.Permissions.dll => 0xbf863f06 => 58
	i32 3220365878, ; 265: System.Threading => 0xbff2e236 => 164
	i32 3258312781, ; 266: Xamarin.AndroidX.CardView => 0xc235e84d => 63
	i32 3290767353, ; 267: System.Security.Cryptography.Encoding => 0xc4251ff9 => 150
	i32 3305363605, ; 268: fi\Microsoft.Maui.Controls.resources => 0xc503d895 => 7
	i32 3316684772, ; 269: System.Net.Requests.dll => 0xc5b097e4 => 121
	i32 3317135071, ; 270: Xamarin.AndroidX.CustomView.dll => 0xc5b776df => 68
	i32 3346324047, ; 271: Xamarin.AndroidX.Navigation.Runtime => 0xc774da4f => 78
	i32 3357674450, ; 272: ru\Microsoft.Maui.Controls.resources => 0xc8220bd2 => 24
	i32 3358260929, ; 273: System.Text.Json => 0xc82afec1 => 159
	i32 3362522851, ; 274: Xamarin.AndroidX.Core => 0xc86c06e3 => 66
	i32 3366347497, ; 275: Java.Interop => 0xc8a662e9 => 172
	i32 3374999561, ; 276: Xamarin.AndroidX.RecyclerView => 0xc92a6809 => 80
	i32 3381016424, ; 277: da\Microsoft.Maui.Controls.resources => 0xc9863768 => 3
	i32 3381033598, ; 278: K4os.Compression.LZ4 => 0xc9867a7e => 37
	i32 3395150330, ; 279: System.Runtime.CompilerServices.Unsafe.dll => 0xca5de1fa => 136
	i32 3428513518, ; 280: Microsoft.Extensions.DependencyInjection.dll => 0xcc5af6ee => 42
	i32 3430777524, ; 281: netstandard => 0xcc7d82b4 => 170
	i32 3463511458, ; 282: hr/Microsoft.Maui.Controls.resources.dll => 0xce70fda2 => 11
	i32 3467345667, ; 283: MySql.Data => 0xceab7f03 => 53
	i32 3471940407, ; 284: System.ComponentModel.TypeConverter.dll => 0xcef19b37 => 100
	i32 3476120550, ; 285: Mono.Android => 0xcf3163e6 => 174
	i32 3479583265, ; 286: ru/Microsoft.Maui.Controls.resources.dll => 0xcf663a21 => 24
	i32 3484440000, ; 287: ro\Microsoft.Maui.Controls.resources => 0xcfb055c0 => 23
	i32 3485117614, ; 288: System.Text.Json.dll => 0xcfbaacae => 159
	i32 3499097210, ; 289: Google.Protobuf.dll => 0xd08ffc7a => 36
	i32 3509114376, ; 290: System.Xml.Linq => 0xd128d608 => 166
	i32 3580758918, ; 291: zh-HK\Microsoft.Maui.Controls.resources => 0xd56e0b86 => 31
	i32 3605570793, ; 292: BouncyCastle.Cryptography => 0xd6e8a4e9 => 35
	i32 3608519521, ; 293: System.Linq.dll => 0xd715a361 => 114
	i32 3624195450, ; 294: System.Runtime.InteropServices.RuntimeInformation => 0xd804d57a => 138
	i32 3641597786, ; 295: Xamarin.AndroidX.Lifecycle.LiveData.Core => 0xd90e5f5a => 72
	i32 3643446276, ; 296: tr\Microsoft.Maui.Controls.resources => 0xd92a9404 => 28
	i32 3643854240, ; 297: Xamarin.AndroidX.Navigation.Fragment => 0xd930cda0 => 77
	i32 3645630983, ; 298: Google.Protobuf => 0xd94bea07 => 36
	i32 3657292374, ; 299: Microsoft.Extensions.Configuration.Abstractions.dll => 0xd9fdda56 => 41
	i32 3660523487, ; 300: System.Net.NetworkInformation => 0xda2f27df => 119
	i32 3672681054, ; 301: Mono.Android.dll => 0xdae8aa5e => 174
	i32 3689375977, ; 302: System.Drawing.Common => 0xdbe768e9 => 56
	i32 3697841164, ; 303: zh-Hant/Microsoft.Maui.Controls.resources.dll => 0xdc68940c => 33
	i32 3716563718, ; 304: System.Runtime.Intrinsics => 0xdd864306 => 140
	i32 3724971120, ; 305: Xamarin.AndroidX.Navigation.Common.dll => 0xde068c70 => 76
	i32 3732100267, ; 306: System.Net.NameResolution => 0xde7354ab => 118
	i32 3737834244, ; 307: System.Net.Http.Json.dll => 0xdecad304 => 116
	i32 3748608112, ; 308: System.Diagnostics.DiagnosticSource => 0xdf6f3870 => 104
	i32 3786282454, ; 309: Xamarin.AndroidX.Collection => 0xe1ae15d6 => 64
	i32 3792276235, ; 310: System.Collections.NonGeneric => 0xe2098b0b => 95
	i32 3802395368, ; 311: System.Collections.Specialized.dll => 0xe2a3f2e8 => 96
	i32 3823082795, ; 312: System.Security.Cryptography.dll => 0xe3df9d2b => 153
	i32 3841636137, ; 313: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 0xe4fab729 => 43
	i32 3849253459, ; 314: System.Runtime.InteropServices.dll => 0xe56ef253 => 139
	i32 3873536506, ; 315: System.Security.Principal => 0xe6e179fa => 155
	i32 3875112723, ; 316: System.Security.Cryptography.Encoding.dll => 0xe6f98713 => 150
	i32 3885497537, ; 317: System.Net.WebHeaderCollection.dll => 0xe797fcc1 => 126
	i32 3889960447, ; 318: zh-Hans/Microsoft.Maui.Controls.resources.dll => 0xe7dc15ff => 32
	i32 3896106733, ; 319: System.Collections.Concurrent.dll => 0xe839deed => 94
	i32 3896760992, ; 320: Xamarin.AndroidX.Core.dll => 0xe843daa0 => 66
	i32 3928044579, ; 321: System.Xml.ReaderWriter => 0xea213423 => 167
	i32 3930554604, ; 322: System.Security.Principal.dll => 0xea4780ec => 155
	i32 3931092270, ; 323: Xamarin.AndroidX.Navigation.UI => 0xea4fb52e => 79
	i32 3953953790, ; 324: System.Text.Encoding.CodePages => 0xebac8bfe => 156
	i32 3955647286, ; 325: Xamarin.AndroidX.AppCompat.dll => 0xebc66336 => 61
	i32 3980434154, ; 326: th/Microsoft.Maui.Controls.resources.dll => 0xed409aea => 27
	i32 3987592930, ; 327: he/Microsoft.Maui.Controls.resources.dll => 0xedadd6e2 => 9
	i32 4003436829, ; 328: System.Diagnostics.Process.dll => 0xee9f991d => 105
	i32 4023392905, ; 329: System.IO.Pipelines => 0xefd01a89 => 57
	i32 4025784931, ; 330: System.Memory => 0xeff49a63 => 115
	i32 4046471985, ; 331: Microsoft.Maui.Controls.Xaml.dll => 0xf1304331 => 49
	i32 4054681211, ; 332: System.Reflection.Emit.ILGeneration => 0xf1ad867b => 132
	i32 4068434129, ; 333: System.Private.Xml.Linq.dll => 0xf27f60d1 => 130
	i32 4073602200, ; 334: System.Threading.dll => 0xf2ce3c98 => 164
	i32 4094352644, ; 335: Microsoft.Maui.Essentials.dll => 0xf40add04 => 51
	i32 4099507663, ; 336: System.Drawing.dll => 0xf45985cf => 108
	i32 4100113165, ; 337: System.Private.Uri => 0xf462c30d => 129
	i32 4102112229, ; 338: pt/Microsoft.Maui.Controls.resources.dll => 0xf48143e5 => 22
	i32 4125707920, ; 339: ms/Microsoft.Maui.Controls.resources.dll => 0xf5e94e90 => 17
	i32 4126470640, ; 340: Microsoft.Extensions.DependencyInjection => 0xf5f4f1f0 => 42
	i32 4147896353, ; 341: System.Reflection.Emit.ILGeneration.dll => 0xf73be021 => 132
	i32 4150914736, ; 342: uk\Microsoft.Maui.Controls.resources => 0xf769eeb0 => 29
	i32 4181436372, ; 343: System.Runtime.Serialization.Primitives => 0xf93ba7d4 => 144
	i32 4182413190, ; 344: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 0xf94a8f86 => 74
	i32 4196529839, ; 345: System.Net.WebClient.dll => 0xfa21f6af => 125
	i32 4213026141, ; 346: System.Diagnostics.DiagnosticSource.dll => 0xfb1dad5d => 104
	i32 4271975918, ; 347: Microsoft.Maui.Controls.dll => 0xfea12dee => 48
	i32 4274976490, ; 348: System.Runtime.Numerics => 0xfecef6ea => 142
	i32 4292120959 ; 349: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 0xffd4917f => 74
], align 4

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [350 x i32] [
	i32 119, ; 0
	i32 118, ; 1
	i32 140, ; 2
	i32 54, ; 3
	i32 162, ; 4
	i32 33, ; 5
	i32 151, ; 6
	i32 52, ; 7
	i32 139, ; 8
	i32 161, ; 9
	i32 126, ; 10
	i32 151, ; 11
	i32 64, ; 12
	i32 83, ; 13
	i32 30, ; 14
	i32 31, ; 15
	i32 101, ; 16
	i32 92, ; 17
	i32 133, ; 18
	i32 2, ; 19
	i32 30, ; 20
	i32 60, ; 21
	i32 15, ; 22
	i32 71, ; 23
	i32 14, ; 24
	i32 165, ; 25
	i32 123, ; 26
	i32 162, ; 27
	i32 115, ; 28
	i32 163, ; 29
	i32 34, ; 30
	i32 26, ; 31
	i32 97, ; 32
	i32 70, ; 33
	i32 152, ; 34
	i32 144, ; 35
	i32 169, ; 36
	i32 128, ; 37
	i32 13, ; 38
	i32 7, ; 39
	i32 47, ; 40
	i32 44, ; 41
	i32 112, ; 42
	i32 137, ; 43
	i32 21, ; 44
	i32 148, ; 45
	i32 38, ; 46
	i32 91, ; 47
	i32 68, ; 48
	i32 19, ; 49
	i32 158, ; 50
	i32 94, ; 51
	i32 122, ; 52
	i32 1, ; 53
	i32 166, ; 54
	i32 16, ; 55
	i32 4, ; 56
	i32 141, ; 57
	i32 91, ; 58
	i32 121, ; 59
	i32 111, ; 60
	i32 25, ; 61
	i32 46, ; 62
	i32 103, ; 63
	i32 56, ; 64
	i32 129, ; 65
	i32 110, ; 66
	i32 116, ; 67
	i32 99, ; 68
	i32 28, ; 69
	i32 54, ; 70
	i32 87, ; 71
	i32 71, ; 72
	i32 168, ; 73
	i32 53, ; 74
	i32 97, ; 75
	i32 112, ; 76
	i32 81, ; 77
	i32 108, ; 78
	i32 43, ; 79
	i32 3, ; 80
	i32 61, ; 81
	i32 107, ; 82
	i32 113, ; 83
	i32 73, ; 84
	i32 100, ; 85
	i32 88, ; 86
	i32 169, ; 87
	i32 16, ; 88
	i32 59, ; 89
	i32 22, ; 90
	i32 78, ; 91
	i32 20, ; 92
	i32 105, ; 93
	i32 18, ; 94
	i32 2, ; 95
	i32 69, ; 96
	i32 114, ; 97
	i32 32, ; 98
	i32 81, ; 99
	i32 135, ; 100
	i32 65, ; 101
	i32 143, ; 102
	i32 136, ; 103
	i32 0, ; 104
	i32 87, ; 105
	i32 109, ; 106
	i32 137, ; 107
	i32 122, ; 108
	i32 6, ; 109
	i32 111, ; 110
	i32 62, ; 111
	i32 47, ; 112
	i32 110, ; 113
	i32 93, ; 114
	i32 39, ; 115
	i32 10, ; 116
	i32 5, ; 117
	i32 160, ; 118
	i32 25, ; 119
	i32 125, ; 120
	i32 75, ; 121
	i32 85, ; 122
	i32 67, ; 123
	i32 117, ; 124
	i32 160, ; 125
	i32 98, ; 126
	i32 145, ; 127
	i32 86, ; 128
	i32 120, ; 129
	i32 153, ; 130
	i32 149, ; 131
	i32 63, ; 132
	i32 23, ; 133
	i32 1, ; 134
	i32 165, ; 135
	i32 57, ; 136
	i32 93, ; 137
	i32 106, ; 138
	i32 83, ; 139
	i32 44, ; 140
	i32 173, ; 141
	i32 17, ; 142
	i32 70, ; 143
	i32 9, ; 144
	i32 75, ; 145
	i32 88, ; 146
	i32 86, ; 147
	i32 79, ; 148
	i32 157, ; 149
	i32 143, ; 150
	i32 45, ; 151
	i32 59, ; 152
	i32 29, ; 153
	i32 26, ; 154
	i32 113, ; 155
	i32 134, ; 156
	i32 8, ; 157
	i32 135, ; 158
	i32 95, ; 159
	i32 37, ; 160
	i32 130, ; 161
	i32 82, ; 162
	i32 40, ; 163
	i32 5, ; 164
	i32 73, ; 165
	i32 0, ; 166
	i32 131, ; 167
	i32 72, ; 168
	i32 4, ; 169
	i32 106, ; 170
	i32 145, ; 171
	i32 127, ; 172
	i32 102, ; 173
	i32 96, ; 174
	i32 50, ; 175
	i32 12, ; 176
	i32 46, ; 177
	i32 45, ; 178
	i32 128, ; 179
	i32 89, ; 180
	i32 117, ; 181
	i32 14, ; 182
	i32 146, ; 183
	i32 41, ; 184
	i32 8, ; 185
	i32 80, ; 186
	i32 124, ; 187
	i32 18, ; 188
	i32 171, ; 189
	i32 138, ; 190
	i32 120, ; 191
	i32 167, ; 192
	i32 40, ; 193
	i32 149, ; 194
	i32 154, ; 195
	i32 13, ; 196
	i32 10, ; 197
	i32 102, ; 198
	i32 124, ; 199
	i32 170, ; 200
	i32 172, ; 201
	i32 48, ; 202
	i32 98, ; 203
	i32 123, ; 204
	i32 39, ; 205
	i32 35, ; 206
	i32 133, ; 207
	i32 11, ; 208
	i32 92, ; 209
	i32 158, ; 210
	i32 157, ; 211
	i32 163, ; 212
	i32 20, ; 213
	i32 89, ; 214
	i32 90, ; 215
	i32 131, ; 216
	i32 67, ; 217
	i32 15, ; 218
	i32 141, ; 219
	i32 168, ; 220
	i32 107, ; 221
	i32 103, ; 222
	i32 147, ; 223
	i32 142, ; 224
	i32 60, ; 225
	i32 161, ; 226
	i32 62, ; 227
	i32 21, ; 228
	i32 49, ; 229
	i32 50, ; 230
	i32 156, ; 231
	i32 84, ; 232
	i32 27, ; 233
	i32 52, ; 234
	i32 6, ; 235
	i32 65, ; 236
	i32 19, ; 237
	i32 58, ; 238
	i32 84, ; 239
	i32 51, ; 240
	i32 171, ; 241
	i32 85, ; 242
	i32 127, ; 243
	i32 55, ; 244
	i32 101, ; 245
	i32 154, ; 246
	i32 148, ; 247
	i32 69, ; 248
	i32 82, ; 249
	i32 55, ; 250
	i32 38, ; 251
	i32 34, ; 252
	i32 76, ; 253
	i32 173, ; 254
	i32 99, ; 255
	i32 12, ; 256
	i32 90, ; 257
	i32 152, ; 258
	i32 147, ; 259
	i32 109, ; 260
	i32 146, ; 261
	i32 134, ; 262
	i32 77, ; 263
	i32 58, ; 264
	i32 164, ; 265
	i32 63, ; 266
	i32 150, ; 267
	i32 7, ; 268
	i32 121, ; 269
	i32 68, ; 270
	i32 78, ; 271
	i32 24, ; 272
	i32 159, ; 273
	i32 66, ; 274
	i32 172, ; 275
	i32 80, ; 276
	i32 3, ; 277
	i32 37, ; 278
	i32 136, ; 279
	i32 42, ; 280
	i32 170, ; 281
	i32 11, ; 282
	i32 53, ; 283
	i32 100, ; 284
	i32 174, ; 285
	i32 24, ; 286
	i32 23, ; 287
	i32 159, ; 288
	i32 36, ; 289
	i32 166, ; 290
	i32 31, ; 291
	i32 35, ; 292
	i32 114, ; 293
	i32 138, ; 294
	i32 72, ; 295
	i32 28, ; 296
	i32 77, ; 297
	i32 36, ; 298
	i32 41, ; 299
	i32 119, ; 300
	i32 174, ; 301
	i32 56, ; 302
	i32 33, ; 303
	i32 140, ; 304
	i32 76, ; 305
	i32 118, ; 306
	i32 116, ; 307
	i32 104, ; 308
	i32 64, ; 309
	i32 95, ; 310
	i32 96, ; 311
	i32 153, ; 312
	i32 43, ; 313
	i32 139, ; 314
	i32 155, ; 315
	i32 150, ; 316
	i32 126, ; 317
	i32 32, ; 318
	i32 94, ; 319
	i32 66, ; 320
	i32 167, ; 321
	i32 155, ; 322
	i32 79, ; 323
	i32 156, ; 324
	i32 61, ; 325
	i32 27, ; 326
	i32 9, ; 327
	i32 105, ; 328
	i32 57, ; 329
	i32 115, ; 330
	i32 49, ; 331
	i32 132, ; 332
	i32 130, ; 333
	i32 164, ; 334
	i32 51, ; 335
	i32 108, ; 336
	i32 129, ; 337
	i32 22, ; 338
	i32 17, ; 339
	i32 42, ; 340
	i32 132, ; 341
	i32 29, ; 342
	i32 144, ; 343
	i32 74, ; 344
	i32 125, ; 345
	i32 104, ; 346
	i32 48, ; 347
	i32 142, ; 348
	i32 74 ; 349
], align 4

@marshal_methods_number_of_classes = dso_local local_unnamed_addr constant i32 0, align 4

@marshal_methods_class_cache = dso_local local_unnamed_addr global [0 x %struct.MarshalMethodsManagedClass] zeroinitializer, align 4

; Names of classes in which marshal methods reside
@mm_class_names = dso_local local_unnamed_addr constant [0 x ptr] zeroinitializer, align 4

@mm_method_names = dso_local local_unnamed_addr constant [1 x %struct.MarshalMethodName] [
	%struct.MarshalMethodName {
		i64 0, ; id 0x0; name: 
		ptr @.MarshalMethodName.0_name; char* name
	} ; 0
], align 8

; get_function_pointer (uint32_t mono_image_index, uint32_t class_index, uint32_t method_token, void*& target_ptr)
@get_function_pointer = internal dso_local unnamed_addr global ptr null, align 4

; Functions

; Function attributes: "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" uwtable willreturn
define void @xamarin_app_init(ptr nocapture noundef readnone %env, ptr noundef %fn) local_unnamed_addr #0
{
	%fnIsNull = icmp eq ptr %fn, null
	br i1 %fnIsNull, label %1, label %2

1: ; preds = %0
	%putsResult = call noundef i32 @puts(ptr @.str.0)
	call void @abort()
	unreachable 

2: ; preds = %1, %0
	store ptr %fn, ptr @get_function_pointer, align 4, !tbaa !3
	ret void
}

; Strings
@.str.0 = private unnamed_addr constant [40 x i8] c"get_function_pointer MUST be specified\0A\00", align 1

;MarshalMethodName
@.MarshalMethodName.0_name = private unnamed_addr constant [1 x i8] c"\00", align 1

; External functions

; Function attributes: noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8"
declare void @abort() local_unnamed_addr #2

; Function attributes: nofree nounwind
declare noundef i32 @puts(ptr noundef) local_unnamed_addr #1
attributes #0 = { "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "stackrealign" "target-cpu"="i686" "target-features"="+cx8,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "tune-cpu"="generic" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "stackrealign" "target-cpu"="i686" "target-features"="+cx8,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "tune-cpu"="generic" }

; Metadata
!llvm.module.flags = !{!0, !1, !7}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!"Xamarin.Android remotes/origin/release/8.0.2xx @ 0d97e20b84d8e87c3502469ee395805907905fe3"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{i32 1, !"NumRegisterParameters", i32 0}
