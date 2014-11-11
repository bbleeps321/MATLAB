%AllCurrents
%Simulation 1: Postsynaptic Cytosolic Currents 
t1 = [0.0	 5.0E-4	 11.1645	 11.166	 11.167	 11.168	 11.169	 11.17	 11.171	 11.1715	 11.172	 11.1725	 11.173	 11.1735	 11.174	 11.1745	 11.175	 11.1755	 11.176	 11.1765	 11.177	 11.1775	 11.178	 11.1785	 11.179	 11.1795	 11.18	 11.1805	 11.181	 11.1815	 11.182	 11.1825	 11.183	 11.1835	 11.184	 11.1845	 11.185	 11.1855	 11.186	 11.1865	 11.187	 11.1875	 11.188	 11.1885	 11.189	 11.1895	 11.19	 11.1905	 11.191	 11.1915	 11.192	 11.1925	 11.193	 11.1935	 11.194	 11.1945	 11.195	 11.1955	 11.196	 11.1965	 11.197	 11.1975	 11.198	 11.1985	 11.199	 11.1995	 11.2	 11.2005	 11.201	 11.2015	 11.202	 11.2025	 11.203	 11.2035	 11.204	 11.2045	 11.205	 11.2055	 11.206	 11.2065	 11.207	 11.2075	 11.208	 11.2085	 11.209	 11.2095	 11.21	 11.2105	 11.211	 11.2115	 11.212	 11.2125	 11.213	 11.2135	 11.214	 11.2145	 11.215	 11.2155	 11.216	 11.2165	 11.217	 11.2175	 11.218	 11.2185	 11.219	 11.2195	 11.22	 11.2205	 11.221	 11.2215	 11.222	 11.2225	 11.223	 11.2235	 11.224	 11.2245	 11.225	 11.2255	 11.226	 11.2265	 11.227	 11.2275	 11.228	 11.2285	 11.229	 11.2295	 11.23	 11.2305	 11.231	 11.2315	 11.232	 11.2325	 11.233	 11.2335	 11.234	 11.2345	 11.235	 11.2355	 11.236	 11.2365	 11.237	 11.2375	 11.238	 11.2385	 11.239	 11.2395	 11.24	 11.2405	 11.241	 11.2415	 11.242	 11.2425	 11.243	 11.2435	 11.244	 11.2445	 11.245	 11.2455	 11.246	 11.2465	 11.247	 11.2475	 11.248	 11.2485	 11.249	 11.2495	 11.25	 11.2505	 11.251	 11.2515	 11.252	 11.2525	 11.253	 11.2535	 11.254	 11.2545	 11.255	 11.2555	 11.256	 11.2565	 11.257	 11.2575	 11.258	 11.2585	 11.259	 11.2595	 11.26	 11.2605	 11.261	 11.2615	 11.262	 11.2625	 11.263	 11.2635	 11.264	 11.2645	 11.265	 11.2655	 11.266	 11.2665	 11.267	 11.2675	 11.268	 11.2685	 11.269	 11.2695	 11.27	 11.2705	 11.271	 11.2715	 11.272	 11.2725	 11.273	 11.2735	 11.274	 11.2745	 11.275	 11.2755	 11.2765	 11.2775	 11.2785	 11.2795	 11.2805	 11.2815	 11.2825	 11.2835	 11.2845	 11.2855	 11.2865	 11.2875	 11.2885	 11.2895	 11.2905	 11.2915	 11.2925	 11.2935	 11.2945	 11.2955	 11.2965	 11.2975	 11.2985	 11.2995	 11.3005	 11.3015	 11.3025	 11.3035	 11.3045	 11.3055	 11.3065	 11.3075	 11.3085	 11.3095	 11.3105	 11.3115	 11.3125	 11.3135	 11.3145	 11.3155	 11.3165	 11.3175	 11.3185	 11.3195	 11.3205	 11.3215	 11.3225	 11.3235	 11.3245	 11.3255	 11.3265	 11.3275	 11.3285	 11.3295	 11.3305	 11.3315	 11.3325	 11.3335	 11.3345	 11.3355	 11.3365	 11.3375	 11.3385	 11.3395	 11.3405	 11.3415	 11.3425	 11.3435	 11.3445	 11.3455	 11.3465	 11.348	 11.3495	 11.351	 11.3525	 11.354	 11.3555	 11.357	 11.3585	 11.36	 11.3615	 11.363	 11.3645	 11.366	 11.3675	 11.369	 11.3705	 11.372	 11.3735	 11.375	 11.3765	 11.378	 11.3795	 11.381	 11.3825	 11.384	 11.3855	 11.387	 11.389	 11.391	 11.393	 11.395	 11.397	 11.399	 11.401	 11.403	 11.405	 11.407	 11.409	 11.411	 11.413	 11.415	 11.4155	 11.418	 11.4215	 11.422	 11.4245	 11.4275	 11.428	 11.4305	 11.4325	 11.433	 11.444	 11.4445	 11.4485	 11.4515	 11.4625	 11.463	 11.4695	 11.481	 11.4815	 11.4875	 11.499	 11.4995	 11.5165	 11.517	 11.534	 11.5345	 11.55	 11.5505	 11.5645	 11.565	 11.583	 11.6115	 11.7165	 11.7555	 11.756	 11.7755	 11.776	 11.797	 11.7975	 11.8185	 11.819	 11.8405	 11.841	 11.8635	 11.864	 11.887	 11.8875	 11.911	 11.9115	 11.9355	 11.936	 11.961	 11.9615	 11.9865	 11.987	 12.013	 12.0135	 12.0405	 12.041	 12.068	 12.0685	 12.0965	 12.097	 12.1255	 12.126	 12.1555	 12.156	 12.186	 12.1865	 12.217	 12.2175	 12.2485	 12.249	 12.281	 12.2815	 12.3135	 12.314	 12.3475	 12.348	 12.3815	 12.382	 12.416	 12.4165	 12.4515	 12.452	 12.4875	 12.488	 12.524	 12.5245	 12.561	 12.5615	 12.599	 12.5995	 12.6375	 12.638	 12.676	 12.6765	 12.7155	 12.716	 12.7555	 12.756	 12.796	 12.7965	 12.8375	 12.838	 12.879	 12.8795	 12.921	 12.9215	 12.964	 12.9645	 13.007	 13.0075	 13.051	 13.0515	 13.0955	 13.096	 13.1405	 13.141	 13.186	 13.1865	 13.232	 13.2325	 13.2785	 13.279	 13.337	 13.3375	 13.384	 13.3845	 13.44	 13.4405	 13.4885	 13.489	 13.549	 13.5495	 13.5985	 13.599	 13.6565	 13.657	 13.7075	 13.708	 13.77	 13.7705	 13.8215	 13.822	 13.881	 13.8815	 13.9335	 13.934	 13.982	 13.9825	 14.034	 14.0345	 14.0955	 14.096	 14.1505	 14.151	 14.216	 14.2165	 14.272	 14.2725	 14.3385	 14.339	 14.3955	 14.396	 14.463	 14.4635	 14.5205	 14.521	 14.582	 14.5825	 14.6405	 14.641	 14.7095	 14.71	 14.769	 14.7695	 14.836	 14.8365	 14.8965	 14.897	 14.958	 14.9585	 15.0185	 15.019	 15.0815	 15.082	 15.1445	 15.145	 15.2085	 15.209	 15.2725	 15.273	 15.3365	 15.337	 15.4015	 15.402	 15.4665	 15.467	 15.532	 15.5325	 15.598	 15.5985	 15.6645	 15.665	 15.731	 15.7315	 15.798	 15.7985	 15.8655	 15.866	 15.9335	 15.934	 16.002	 16.0025	 16.0705	 16.071	 16.14	 16.1405	 16.2095	 16.21	 16.279	 16.2795	 16.3495	 16.35	 16.42	 16.4205	 16.491	 16.4915	 16.5625	 16.563	 16.6345	 16.635	 16.7065	 16.707	 16.779	 16.7795	 16.852	 16.8525	 16.925	 16.9255	 16.9985	 16.999	 17.0725	 17.073	 17.147	 17.1475	 17.2215	 17.222	 17.297	 17.2975	 17.372	 17.3725	 17.448	 17.4485	 17.524	 17.5245	 17.6005	 17.601	 17.677	 17.6775	 17.754	 17.7545	 17.8315	 17.832	 17.9095	 17.91	 17.9875	 17.988	 18.066	 18.0665	 18.1445	 18.145	 18.2235	 18.224	 18.303	 18.3035	 18.383	 18.3835	 18.463	 18.4635	 18.5435	 18.544	 18.624	 18.6245	 18.705	 18.7055	 18.7865	 18.787	 18.868	 18.8685	 18.95	 18.9505	 19.032	 19.0325	 19.115	 19.1155	 19.1975	 19.198	 19.281	 19.2815	 19.3645	 19.365	 19.448	 19.4485	 19.5325	 19.533	 19.6165	 19.617	 19.7015	 19.702	 19.7865	 19.787	 19.872	 19.8725	 19.9575	 19.958	 20.043	 20.0435	 20.1295	 20.13	 20.216	 20.2165	 20.303	 20.3035	 20.39	 20.3905	 20.477	 20.4775	 20.565	 20.5655	 20.653	 20.6535	 20.741	 20.7415	 20.8295	 20.83	 20.9185	 20.919	 21.097	 21.0975	 21.1465	 21.1485	 21.15	 21.1515	 21.1525	 21.1535	 21.1545	 21.1555	 21.1565	 21.1575	 21.1585	 21.1595	 21.1605	 21.1615	 21.1625	 21.1635	 21.1645	 21.1655	 21.1665	 21.1675	 21.1685	 21.1695	 21.1705	 21.1715	 21.1725	 21.1735	 21.1745	 21.1755	 21.1765	 21.1775	 21.1785	 21.1795	 21.1805	 21.1815	 21.1825	 21.1835	 21.1845	 21.1855	 21.1865	 21.1875	 21.1885	 21.1895	 21.1905	 21.1915	 21.1925	 21.1935	 21.1945	 21.1955	 21.1965	 21.1975	 21.1985	 21.1995	 21.2005	 21.2015	 21.2025	 21.2035	 21.2045	 21.2055	 21.2065	 21.2075	 21.2085	 21.2095	 21.2105	 21.2115	 21.2125	 21.2135	 21.2145	 21.2155	 21.2165	 21.2175	 21.2185	 21.2195	 21.2205	 21.2215	 21.2225	 21.2235	 21.2245	 21.2255	 21.2265	 21.2275	 21.2285	 21.2295	 21.2305	 21.2315	 21.2325	 21.2335	 21.2345	 21.2355	 21.2365	 21.2375	 21.2385	 21.2395	 21.2405	 21.2415	 21.2425	 21.2435	 21.2445	 21.2455	 21.2465	 21.2475	 21.2485	 21.2495	 21.2505	 21.2515	 21.2525	 21.2535	 21.2545	 21.2555	 21.2565	 21.2575	 21.2585	 21.2595	 21.2605	 21.2615	 21.2625	 21.2635	 21.265	 21.2665	 21.268	 21.2695	 21.271	 21.2725	 21.274	 21.2755	 21.277	 21.2785	 21.28	 21.2815	 21.283	 21.2845	 21.286	 21.2875	 21.289	 21.2905	 21.292	 21.2935	 21.295	 21.2965	 21.298	 21.2995	 21.301	 21.3025	 21.304	 21.3055	 21.307	 21.309	 21.311	 21.313	 21.315	 21.3175	 21.318	 21.328	 21.3285	 21.331	 21.3345	 21.335	 21.345	 21.3455	 21.3485	 21.3515	 21.352	 21.362	 21.3625	 21.366	 21.3785	 21.379	 21.3845	 21.395	 21.3955	 21.4005	 21.411	 21.4115	 21.427	 21.4275	 21.443	 21.4435	 21.4555	 21.456	 21.469	 21.4695	 21.4825	 21.483	 21.496	 21.4965	 21.5105	 21.511	 21.525	 21.5255	 21.5555	 21.5875	 21.754	 21.7965	 21.8415	 21.8885	 21.889	 21.913	 21.9135	 21.938	 21.9385	 21.9635	 21.964	 21.99	 21.9905	 22.017	 22.0175	 22.0445	 22.045	 22.073	 22.0735	 22.102	 22.1025	 22.1315	 22.132	 22.1615	 22.162	 22.1925	 22.193	 22.224	 22.2245	 22.2565	 22.257	 22.289	 22.2895	 22.3225	 22.323	 22.357	 22.3575	 22.3915	 22.392	 22.427	 22.4275	 22.463	 22.4635	 22.4995	 22.5	 22.537	 22.5375	 22.5745	 22.575	 22.613	 22.6135	 22.652	 22.6525	 22.6915	 22.692	 22.732	 22.7325	 22.7725	 22.773	 22.814	 22.8145	 22.8555	 22.856	 22.898	 22.8985	 22.941	 22.9415	 22.9845	 22.985	 23.0285	 23.029	 23.073	 23.0735	 23.118	 23.1185	 23.1635	 23.164	 23.21	 23.2105	 23.2565	 23.257	 23.304	 23.3045	 23.3515	 23.352	 23.3995	 23.4	 23.4485	 23.449	 23.4975	 23.498	 23.5475	 23.548	 23.5975	 23.598	 23.6485	 23.649	 23.6995	 23.7	 23.7515	 23.752	 23.8035	 23.804	 23.8565	 23.857	 23.9095	 23.91	 23.9635	 23.964	 24.0175	 24.018	 24.072	 24.0725	 24.127	 24.1275	 24.183	 24.1835	 24.239	 24.2395	 24.2955	 24.296	 24.3525	 24.353	 24.41	 24.4105	 24.468	 24.4685	 24.526	 24.5265	 24.585	 24.5855	 24.6445	 24.645	 24.704	 24.7045	 24.7645	 24.765	 24.825	 24.8255	 24.886	 24.8865	 24.9475	 24.948	 25.0095	 25.01	 25.072	 25.0725	 25.135	 25.1355	 25.1985	 25.199	 25.262	 25.2625	 25.326	 25.3265	 25.391	 25.3915	 25.456	 25.4565	 25.5215	 25.522	 25.587	 25.5875	 25.6535	 25.654	 25.72	 25.7205	 25.787	 25.7875	 25.8545	 25.855	 25.9225	 25.923	 25.991	 25.9915	 26.0595	 26.06	 26.129	 26.1295	 26.1985	 26.199	 26.2685	 26.269	 26.3385	 26.339	 26.4095	 26.41	 26.4805	 26.481	 26.552	 26.5525	 26.624	 26.6245	 26.696	 26.6965	 26.769	 26.7695	 26.842	 26.8425	 26.9155	 26.916	 26.989	 26.9895	 27.063	 27.0635	 27.138	 27.1385	 27.2125	 27.213	 27.288	 27.2885	 27.3635	 27.364	 27.4395	 27.44	 27.516	 27.5165	 27.593	 27.5935	 27.67	 27.6705	 27.7475	 27.748	 27.825	 27.8255	 27.903	 27.9035	 27.9815	 27.982	 28.0605	 28.061	 28.14	 28.1405	 28.2195	 28.22	 28.299	 28.2995	 28.3795	 28.38	 28.46	 28.4605	 28.541	 28.5415	 28.622	 28.6225	 28.704	 28.7045	 28.7855	 28.786	 28.868	 28.8685	 28.9505	 28.951	 29.1165	 29.117	 29.284	 29.2845	 29.453	 29.4535	 29.623	 29.6235	 29.794	 29.7945	 29.9665	 29.967	 30.1405	 30.141	 30.316	 30.492	 30.6695	 30.8485	 31.028	 31.209	 31.3915	 31.5745	 31.759	 31.945	 32.1315	 32.414	 32.699	 32.986	 33.276	 33.5685	 33.863	 34.2595	 34.6605	 35.0655	 35.475	 35.992	 36.5155	 37.0455	 37.6895	 38.342	 39.085	 39.7855	 40.5795	 41.3845	 42.219	 43.1085	 43.9875	 44.8385	 45.728	 46.6115	 47.497	 48.3825	 49.268	 50.414	 51.282	 52.161	 52.9745	 53.7905	 54.605	 55.415	 56.225	 57.035	 57.845	 58.655	 59.465	 60.275	 61.085	 61.9575	 62.786	 63.677	 64.5635	 65.449	 66.3345	 67.283	 68.249	 69.215	 70.181	 71.147	 72.113	 73.079	 74.045	 75.011	 75.977	 76.943	 77.909	 78.8805	 79.9215	 80.968	 82.095	 83.222	 84.342	 85.462	 86.582	 87.702	 88.8235	 90.022	 91.222	 92.502	 93.782	 95.062	 96.342	 97.6325	 99.0465	 100.4775	 101.9085	 103.3395	 104.771	 106.281	 107.865	 109.445	 111.025	 112.684	 114.4205	 116.1475	 118.35	 120.717	 123.084	 125.451	 127.816	 130.18	 132.544	 134.908	 137.291	 140.03	 143.182	 146.333	 149.481	 152.629	 155.858	 159.712	 163.646	 167.576	 171.899	 176.615	 181.4075	 186.8225	 192.7095	 199.061	 206.113	 214.2515	 225.0065	 236.547	 250.4765	 268.185	 292.6675	 299.9995	 ]; 
r1 = [8.100165308894498E-15 8.213185924830878E-15 -0.03408654606116243 -0.06885102626041742 -0.09922106396494003 -0.13507466272162488 -0.17609712697151272 -0.22194500024232525 -0.272268237632913 -0.2990002617812854 -0.3267232296719877 -0.3553963825136874 -0.3849800688677288 -0.4154358048639266 -0.44672630984748724 -0.4788155230597665 -0.5116686057560708 -0.5452519322242729 -0.5795330724351317 -0.6144807684676161 -0.6500649063974949 -0.6862564849786104 -0.7230275821560036 -0.7603513202235033 -0.7982018302627144 -0.8365542163550368 -0.8753845199441641 -0.9146696846406738 -0.9543875216829993 -0.9945166762175124 -1.035036594513471 -1.075927492193066 -1.117170323528511 -1.1587467518360604 -1.2006391209769107 -1.2428304279701146 -1.285304296701522 -1.3280449527112523 -1.3710371990363444 -1.4142663930761157 -1.45771842445018 -1.5013796938158577 -1.5452370926065313 -1.5892779836588244 -1.6334901826882644 -1.6778619405813526 -1.7223819264651266 -1.7670392115231643 -1.8118232535210037 -1.8567238820120422 -1.9017312841890257 -1.9468359913524407 -1.99202886596813 -2.0373010892842065 -2.0826441494813763 -2.128049830331833 -2.173510200342609 -2.2190176023589303 -2.264564643606821 -2.3101441861544436 -2.355749337770482 -2.401373443163182 -2.447010075579759 -2.4926530287516733 -2.5382963091672903 -2.5839341286576114 -2.6295608972810167 -2.675171216491547 -2.720759872580033 -2.7663218303734776 -2.811852227181727 -2.8573463669806936 -2.902799714820037 -2.948207891447258 -2.993566668136771 -3.03887196171552 -3.0841198297770682 -3.129306466074668 -3.1744281960862106 -3.2194814727441594 -3.264462872322154 -3.3093690904722286 -3.3541969384067865 -3.3989433392180564 -3.4436053243298677 -3.488180030076715 -3.532664694403799 -3.577056653683568 -3.6213533396444872 -3.665552276406495 -3.7096510776192884 -3.7536474436997924 -3.7975391591639425 -3.841324090049434 -3.88500018142633 -3.9285654549913085 -3.9720180067426316 -4.01535600473262 -4.058577686895 -4.101681358943656 -4.14466539234035 -4.187528222329237 -4.230268346034994 -4.272884320622452 -4.315374761515368 -4.357738340672515 -4.399973784918438 -4.4420798743272005 -4.4840554406570226 -4.5258993658343645 -4.5676105804851845 -4.609188062511921 -4.650630835714471 -4.691937968453924 -4.7331085723571835 -4.774141801061162 -4.815036848995211 -4.855792950200351 -4.8964093771843205 -4.936885439810911 -4.977220484222521 -5.017413891794763 -5.057465078122306 -5.097373492034589 -5.137138614640531 -5.176759958401262 -5.216237066229945 -5.255569510617737 -5.29475689278527 -5.33379884185858 -5.372695014068761 -5.411445091974611 -5.450048783707519 -5.488505822237818 -5.526815964661974 -5.5649789915100705 -5.602994706072767 -5.6408629337472105 -5.678583521401268 -5.716156336755559 -5.753581267782698 -5.790858222123216 -5.827987126517697 -5.864967926254563 -5.9018005846330315 -5.938485082440951 -5.975021417446871 -6.011409603905995 -6.047649672079617 -6.083741667767569 -6.11968565185338 -6.155481699861741 -6.191129901527875 -6.226630360378525 -6.261983193324167 -6.29718853026217 -6.332246513690543 -6.367157298331993 -6.401921050767979 -6.436537949082492 -6.4710081825152574 -6.505331951124136 -6.53950946545641 -6.573540946228741 -6.607426624015544 -6.6411667389455395 -6.674761540406242 -6.70821128675622 -6.741516245044814 -6.774676690739203 -6.807692907458571 -6.840565186715158 -6.873293827662064 -6.9058791368475685 -6.938321427975825 -6.970621021673712 -7.002778245263756 -7.034793432542849 -7.066666923566713 -7.098399064439883 -7.129990207111103 -7.1614407091739665 -7.192750933672675 -7.223921248912783 -7.254952028276759 -7.285843650044315 -7.316596497217297 -7.347210957349037 -7.377687422378111 -7.408026288466296 -7.43822795584068 -7.468292828639796 -7.498221314763677 -7.528013825727734 -7.557670776520346 -7.587192585464102 -7.616579674080539 -7.645832466958349 -7.674951391624953 -7.703936878421311 -7.732789360379936 -7.761509273106031 -7.790097054661621 -7.818553145452665 -7.846877988119028 -7.87507202742727 -7.903135710166156 -7.931069485044841 -7.958873802593668 -7.986549115067462 -8.014095876351346 -8.041514541868928 -8.068805568492861 -8.095969414457675 -8.123006539274886 -8.149917403650235 -8.17670246940309 -8.203362199387913 -8.256307508189696 -8.308757050734835 -8.360714559568772 -8.412183776926586 -8.463168452668212 -8.513672342320161 -8.563699205218658 -8.613252802749336 -8.662336896678985 -8.710955247574882 -8.759111613307722 -8.806809747634091 -8.854053398854814 -8.900846308545606 -8.947192210356619 -8.993094828877695 -9.038557878566301 -9.083585062735116 -9.128180072596619 -9.172346586361963 -9.216088268391616 -9.25940876839545 -9.302311720679853 -9.344800743439823 -9.386879438093885 -9.428551388659892 -9.469820161169782 -9.51068930312154 -9.551162342966608 -9.591242789631126 -9.630934132069434 -9.670239838848348 -9.709163357760765 -9.747708115467285 -9.785877517164487 -9.8236749462787 -9.861103764183996 -9.89816730994336 -9.934868900071885 -9.971211828321032 -10.007199365482903 -10.042834759213632 -10.078121233874977 -10.113061990393254 -10.147660206134784 -10.18191903479711 -10.215841606315148 -10.249431026781663 -10.282690378381284 -10.31562271933748 -10.34823108387181 -10.380518482174889 -10.412487900388475 -10.444142300598138 -10.475484620835966 -10.506517775092858 -10.537244653339851 -10.567668121558071 -10.59779102177686 -10.627616172119119 -10.65714636685452 -10.686384376459955 -10.715332947686234 -10.743994803631367 -10.77237264382007 -10.80046914428696 -10.828286957668105 -10.85582871329433 -10.883097017292739 -10.910094452687938 -10.936823579512096 -10.976419734968395 -11.015426366365864 -11.053851826341731 -11.09170435414354 -11.128992076612132 -11.165723009186934 -11.20190505694452 -11.237546015652942 -11.272653572854383 -11.307235308953693 -11.341298698343747 -11.374851110523927 -11.407899811248592 -11.440451963664154 -11.4725146294771 -11.504094770114003 -11.535199247896534 -11.565834827208993 -11.59600817567534 -11.62572586534204 -11.654994373842834 -11.683820085590591 -11.712209292945863 -11.740168197390162 -11.767702910700429 -11.794819456099342 -11.821523769430016 -11.856498368813165 -11.890764131655885 -11.924334424825135 -11.95722235583054 -11.989440777554607 -12.021002292890238 -12.051919259388013 -12.082203793781801 -12.111867776524589 -12.14092285621061 -12.16938045397678 -12.197251767827316 -12.224547776889473 -12.224796012081756 -12.259102886370911 -12.289130135555336 -12.30825330680146 -12.340237032206257 -12.370539576963328 -12.382495276278828 -12.412410839602234 -12.44012512300866 -12.440367169334694 -12.468585676037728 -12.469929868635448 -12.594823742465326 -12.624643365778624 -12.652301281270857 -12.653624586866448 -12.75909974427777 -12.797892080039773 -12.799262200005547 -12.88716418370166 -12.918918331772923 -12.920281845113296 -12.993911945617251 -13.010794929761138 -13.071108118591361 -13.089116244425464 -13.13654369674569 -13.145395843500024 -13.182516272250385 -13.184186007164577 -13.21558091959725 -13.242249688522877 -13.274563003644717 -13.241909675100189 -13.222679133308157 -13.19406647443179 -13.196842866101491 -13.16512963747138 -13.168183289557486 -13.131431082105486 -13.134529869163755 -13.095263500181852 -13.098491724798224 -13.055961216234461 -13.059398852970762 -13.013342119837773 -13.016918801322332 -12.96815779119704 -12.97187570928109 -12.920508970032868 -12.924370753448965 -12.870541501526034 -12.874630853057717 -12.81806221200192 -12.82222042147272 -12.763891535486374 -12.768283696140077 -12.70748160253287 -12.712114195352969 -12.649056841180336 -12.653762467019726 -12.589195399455201 -12.594146278787537 -12.527551369651741 -12.532664359882917 -12.464402538446539 -12.46976835960607 -12.399729623439057 -12.405261759832872 -12.333750255240801 -12.339449096846904 -12.266549742585944 -12.27241578584629 -12.198161056812008 -12.20428910971422 -12.128603497455977 -12.134806066753725 -12.057963590845235 -12.064526763908331 -11.986347411657444 -11.992984686285936 -11.913685821284474 -11.920492174913852 -11.840172458045307 -11.847246511940654 -11.765796216354032 -11.773039949225076 -11.690544080333884 -11.69765401277658 -11.61413409102578 -11.620388885157334 -11.53604370489786 -11.545415010833626 -11.459879326955688 -11.468303502382783 -11.382006459656871 -11.390184866047615 -11.303176927727758 -11.311518540097733 -11.223755319424257 -11.232257921563223 -11.143612535875421 -11.152274666635055 -11.062883455582181 -11.071808979125427 -10.981723826829452 -10.990698570454478 -10.899824446787209 -10.90895255258594 -10.81747222744616 -10.826858399107678 -10.73472170189953 -10.74414914452568 -10.651256915373914 -10.660939077770577 -10.567561909356147 -10.577387767433637 -10.483342265438413 -10.493309945365471 -10.398743014015015 -10.408849524955565 -10.31376455883478 -10.324007326766658 -10.22842153868422 -10.23879791697331 -10.142730886458171 -10.128360673104758 -10.036239899087505 -10.046753430515317 -9.950254507645512 -9.943131398693838 -9.85044116058512 -9.861309766718405 -9.763929358901521 -9.750883327716647 -9.65731161297281 -9.668414864823703 -9.57002873686696 -9.563419485155185 -9.469841751239624 -9.481271967136196 -9.382506749807423 -9.370950925867122 -9.27693417547133 -9.288461334066866 -9.189137012830008 -9.18456404319629 -9.09095787741038 -9.102675646062098 -9.00325218687032 -9.00206201269819 -8.92663861295466 -8.938128192539933 -8.84012318612067 -8.835563491749932 -8.742039617328327 -8.754217481827826 -8.654659708818423 -8.64538517537824 -8.55198083957227 -8.564312562549322 -8.464966086846195 -8.456531139167913 -8.363709613246982 -8.37617952563092 -8.277219353250175 -8.269005794611164 -8.176844920544418 -8.189335705979028 -8.090804912441454 -8.088189904450065 -8.001894183644378 -8.014473652535651 -7.917146658304389 -7.910079405771676 -7.819469656742253 -7.832181428267639 -7.734944926262187 -7.731963858865782 -7.642644933519313 -7.655446512388308 -7.559161544879179 -7.557230843819049 -7.477493957251916 -7.490122952577063 -7.3956808012286235 -7.40885179774104 -7.312755411644981 -7.325877497770992 -7.230203269948982 -7.243459019155839 -7.148659049456568 -7.16184368557901 -7.0676978882811685 -7.080812491731994 -6.987405752060307 -7.0006423329532455 -6.907943271501202 -6.92110429974774 -6.828970308402389 -6.842152043412185 -6.750735582636109 -6.763933819753851 -6.673162015516338 -6.68637437918398 -6.596278455199059 -6.609408434668535 -6.519985492871861 -6.533125761349789 -6.444433927254949 -6.457581022506066 -6.369566913270706 -6.382718385373425 -6.295421255136909 -6.308573902103875 -6.22202426503587 -6.2350850892402425 -6.149284473728633 -6.162432263064365 -6.07745474888657 -6.09050610268831 -6.006249513025122 -6.019205796887995 -5.935780284626756 -5.9488149696859836 -5.866209063485697 -5.879143712522146 -5.797273410653625 -5.810194967969897 -5.729191298198131 -5.742095861583459 -5.661906129426319 -5.67479159357196 -5.595444807718693 -5.608224931962 -5.52972556240458 -5.542483568378465 -5.464870202253698 -5.477603113559946 -5.400828545589028 -5.4134531527374286 -5.337530329208063 -5.350127644888514 -5.275096736637882 -5.2876638372905616 -5.213482586375203 -5.2260175003838825 -5.1527143244390015 -5.165136208279421 -5.092718219801415 -5.10518268707693 -5.033693353685109 -5.0459643238080325 -4.97531937001548 -4.987629608126459 -4.917947762911006 -4.930140061383834 -4.861290714650076 -4.873441872689102 -4.805521841853464 -4.817554851027382 -4.750509091641536 -4.762498375913483 -4.69635878919199 -4.708301733848836 -4.6430317818037805 -4.654926648893384 -4.590548898289902 -4.602322674272643 -4.53884318262835 -4.5505667078913135 -4.488005534669377 -4.4996072381748515 -4.437915676960752 -4.449465541703473 -4.388669953540295 -4.400165562556198 -4.340231736195838 -4.35167149755544 -4.29261821762137 -4.303933791828469 -4.24576580663484 -4.257023663622766 -4.1997554848040455 -4.210888741157019 -4.154475338810875 -4.165549591816083 -4.1100111246030355 -4.121024181882042 -4.066327735671118 -4.077215681955377 -4.023370723092907 -4.034196357429879 -3.981218004784682 -3.991918226908454 -3.939767455640178 -3.950464510441834 -3.8991638547217025 -3.909674009242772 -3.859178301104089 -3.8696828654796036 -3.8200560502187026 -3.830433209663041 -3.7815914849277137 -3.79184359858487 -3.743838157614657 -3.7540791274880156 -3.7068831220934877 -3.716940770068393 -3.6705156470173277 -3.6805604952955258 -3.6349629980034956 -3.6448260195054614 -3.6000359100227497 -3.6098826239456825 -3.5657850467484042 -3.5755595531103794 -3.5322814075222033 -3.5418772210901244 -3.49931707684786 -3.5087379578786457 -3.4671870885099665 -3.4765855838193076 -3.4354948953167637 -3.444771105274059 -3.404444498509536 -3.4137478259138585 -3.374149871689344 -3.3833286266221085 -3.3444629353073507 -3.3538105572454677 -3.3157037386804484 -3.3244869794772987 -3.287013252181922 -3.295963204738942 -3.2592091102384573 -3.267149871296027 -3.2310969448017595 -3.2396383036464598 -3.2042452593930966 -3.1859225984361212 -3.151877357341106 -3.1799740667519596 -3.2146891781496647 -3.2475705828104946 -3.2856531501769153 -3.313638247951519 -3.3435068074379592 -3.375103449350811 -3.40828299025356 -3.442910372738644 -3.478860304603902 -3.5160167423933615 -3.5542723017720768 -3.593527644855137 -3.633690874492456 -3.674676952859258 -3.716407153712978 -3.7588085526497848 -3.8018135565766364 -3.8453594717294948 -3.889388108482768 -3.933845420617165 -3.978681176459826 -4.02384865925708 -4.0693043942053 -4.115007899700211 -4.160921460532184 -4.207009920937901 -4.253240495603606 -4.299582596892221 -4.3460076767342235 -4.392489081777571 -4.439001920533332 -4.485522941382853 -4.532030420428194 -4.5785040582719185 -4.624924884905807 -4.671275171971747 -4.717538351732725 -4.763698942158404 -4.8097424775891735 -4.855655444495778 -4.901425221898827 -4.947040026054759 -4.992488859052623 -5.037761460999809 -5.082848265505322 -5.127740358195804 -5.172429438024238 -5.216907781152712 -5.261168207210593 -5.305204047746656 -5.349009116710043 -5.392577682808772 -5.43590444360783 -5.478984501240318 -5.521813339615775 -5.564386803019431 -5.606701076004692 -5.648752664489056 -5.690538377970977 -5.73205531279155 -5.773300836370787 -5.81427257235381 -5.854968386607148 -5.8953863740098855 -5.935524845988426 -5.9753823187474975 -6.014957502153474 -6.054249289229245 -6.093256746222812 -6.1319791032144115 -6.170415745229476 -6.20856620382701 -6.2464301491350005 -6.284007382306491 -6.321297828371609 -6.358301529462611 -6.395018638390422 -6.431449412552612 -6.467594208154031 -6.503453474722507 -6.539027749903214 -6.574317654516214 -6.6093238878628 -6.644047223267004 -6.6784885038396355 -6.712648638452803 -6.7465285979137795 -6.780129411327588 -6.813452162638424 -6.846497987340538 -6.8792680693497985 -6.9117636380276535 -6.943985965349656 -6.9759363632112095 -7.007616180863567 -7.039026802473545 -7.070169644800754 -7.101046154986484 -7.131657808448747 -7.162006106878214 -7.192092576330153 -7.221918765407636 -7.251486243531655 -7.280796599293891 -7.309851438888216 -7.338652384617156 -7.367201073469747 -7.395499155767375 -7.423548293874473 -7.451350160970949 -7.478906439883498 -7.506218821973068 -7.533289006075833 -7.560118697495268 -7.586709607042899 -7.626152008849097 -7.66506681633166 -7.703459846553623 -7.7413369235427965 -7.7787038729630975 -7.815566517177796 -7.851930670678604 -7.887802135856441 -7.923186699091305 -7.958090127140242 -7.992518163803918 -8.02647652685354 -8.059970905201125 -8.093006956297309 -8.125590303741879 -8.15772653509323 -8.189421199863837 -8.220679807689724 -8.251507826662648 -8.281910681814441 -8.311893753743725 -8.341462377375697 -8.370621840846466 -8.39937738450374 -8.427734200016411 -8.455697429585875 -8.483272165252485 -8.510463448290896 -8.537276268688494 -8.57244650398094 -8.60696425118612 -8.64084090569067 -8.67408769610919 -8.681910438458974 -8.723862696199465 -8.722944040911395 -8.887547021159588 -8.91807821985912 -8.937044385535225 -8.972465426635218 -8.971599215385828 -9.115154025307461 -9.146862632731503 -9.157578262551382 -9.187785551506513 -9.18695610328476 -9.312011773079872 -9.340565721936992 -9.364976178498164 -9.47440824183154 -9.512279300799491 -9.511510036873375 -9.607311374882036 -9.641297075650932 -9.640567506701071 -9.724533931138007 -9.744308071522132 -9.817903252614725 -9.836504002986462 -9.900595297315983 -9.89926922571813 -9.958057464296854 -9.956797000216254 -10.00883435818567 -10.007701419234074 -10.054073583823614 -10.053056508860866 -10.093963159899047 -10.093038975644955 -10.128091141054162 -10.127299144783985 -10.157708684127348 -10.203290394183234 -10.232103287351801 -10.196797209136331 -10.159807012874726 -10.114364186183106 -10.090872265933584 -10.061383081364742 -10.063694091746076 -10.032350360727593 -10.034848618414081 -10.001718146104848 -10.004404402953629 -9.96954818968387 -9.972470178517266 -9.935829996602607 -9.93894613099858 -9.900711738223293 -9.904019666257158 -9.86426232373583 -9.867814753878003 -9.826492598971221 -9.830239449798277 -9.78749623171781 -9.791434587118548 -9.747341398276186 -9.751469093977146 -9.706059378507314 -9.710435738487366 -9.663694313143246 -9.66825926961927 -9.620284014569568 -9.625098490856546 -9.57593123541679 -9.58086408000507 -9.530608175572524 -9.535786493874369 -9.48445827150903 -9.489882160951218 -9.437471312246975 -9.443002167307272 -9.38963391482628 -9.394411203192483 -9.340111526177203 -9.345887500151848 -9.290617710011984 -9.296627179475545 -9.240510832651788 -9.246677188979707 -9.189748765821658 -9.197864738537099 -9.140040335425311 -9.146749059809501 -9.088362945802013 -9.095145422396651 -9.036016385512314 -9.042942256764173 -8.983156950622883 -8.990297593110652 -8.929890165635586 -8.937085816340305 -8.876037925999873 -8.883441624005311 -8.821884503884153 -8.82933297107218 -8.767168118836256 -8.774817541490917 -8.712190793490018 -8.719955517531616 -8.656790562559005 -8.664668281372931 -8.60106171399978 -8.609047346749836 -8.545016210582446 -8.553106006223896 -8.488671526077578 -8.496861746130257 -8.432046451643377 -8.440333412323188 -8.375161042350884 -8.38362103405656 -8.31814566793065 -8.326613431681352 -8.260794662890149 -8.269428958086829 -8.203421574933287 -8.212055621450778 -8.14574070234663 -8.15445486129389 -8.087962537798571 -8.096831113676282 -8.030140389477321 -8.039000431684338 -7.972078050907668 -7.981087554085783 -7.914090886344437 -7.923084626384162 -7.855899326849415 -7.865035965236641 -7.7978206018372695 -7.806935885155728 -7.73957845907932 -7.748830155046351 -7.6814875217879655 -7.6907125552216895 -7.6232750805532135 -7.6326301472484275 -7.565252098213823 -7.574575459474625 -7.507149506100213 -7.51659662878643 -7.44927382583462 -7.458684448094832 -7.391359787801811 -7.400812063046305 -7.333608274379089 -7.3430976743236736 -7.275967235225864 -7.285567489632799 -7.218564412172771 -7.228120241506309 -7.161218713350385 -7.17080554120243 -7.104118190466947 -7.113731724615475 -7.047208512788838 -7.056847495170212 -6.9905147814159605 -7.000176644313138 -6.934057986564507 -6.9436677460263265 -6.877764771735859 -6.887467185786978 -6.821846238460923 -6.831563505749303 -6.76616316289236 -6.775823478271981 -6.710713867693056 -6.720457922107875 -6.655694697269041 -6.665376311073448 -6.600878280416069 -6.610569554802954 -6.54644193959372 -6.556138815176009 -6.492338282389305 -6.502039571519452 -6.438591804490281 -6.448295079321894 -6.38522212481119 -6.394925026473629 -6.33224637131606 -6.341946598211271 -6.279679584577522 -6.289308531910617 -6.227454345448729 -6.237078896184387 -6.175670218816475 -6.18535296310932 -6.124367074138849 -6.133974083801389 -6.073406723520588 -6.08300356651198 -6.022941580154186 -6.032460953134929 -5.972848598766004 -5.982418812564269 -5.923302771258152 -5.932792892016901 -5.8741157045496015 -5.883590096435959 -5.825439926867498 -5.834894878946577 -5.777234527170753 -5.786668892448535 -5.729519323480991 -5.738930861769459 -5.682309019255551 -5.691635914094463 -5.6355458683293715 -5.644907402074111 -5.589382290122785 -5.598655821312437 -5.543641151452295 -5.552887061791031 -5.498457225097473 -5.507614762643152 -5.453723307761722 -5.462908145760595 -5.409589668858633 -5.418683831977891 -5.365891830945694 -5.374953245028669 -5.322759515784053 -5.331784851709012 -5.280154440140377 -5.289088199040819 -5.2380293554748985 -5.24698034155854 -5.196520444448003 -5.205376727140268 -5.155471381483629 -5.164287954846781 -5.1150005036592745 -5.123722130638487 -5.075011684884455 -5.083691943857375 -5.035578382788639 -5.044266011139463 -4.99672817441307 -5.005267958017695 -4.958304963615907 -4.966850556240662 -4.920528056198092 -4.928974895931116 -4.8832109365911744 -4.8916107141239715 -4.846463576499271 -4.854813356465559 -4.81025300851322 -4.818551833898638 -4.774589478271837 -4.782788691735078 -4.739427684346746 -4.747574769445716 -4.704825069836918 -4.7128724110700215 -4.6707016831822745 -4.6786963413033895 -4.637120022102184 -4.645060025987814 -4.604055028223477 -4.611939372108575 -4.571518740232863 -4.579345686216381 -4.539517789575472 -4.5472428538418646 -4.508009145167124 -4.515591209038619 -4.476997289432275 -4.4846055873491055 -4.4465040112135545 -4.454010857073155 -4.41646059709787 -4.4239489394682945 -4.386992483619303 -4.394297925963959 -4.357906322675941 -4.365390176681136 -4.3296138960865145 -4.3367950828054544 -4.301564229171291 -4.30845241975748 -4.274079673437505 -4.28086744310737 -4.246715964411006 -4.227170511187906 -4.1941270206757135 -4.175101751509888 -4.143134530306716 -4.123509657338822 -4.092631644365028 -4.07457125340042 -4.044741671412651 -4.0272379763555515 -3.998432573113598 -3.986016303729266 -3.958213679095112 -3.9429038044563063 -3.916095787364852 -3.8755938764564 -3.8366148053325864 -3.799129404820876 -3.763042532320548 -3.72869085207201 -3.6955035645145062 -3.6636471087426026 -3.6330996792499155 -3.6037586388921783 -3.5755018836240895 -3.5485701598978716 -3.5102410234604635 -3.4741915626134485 -3.440350416242542 -3.4085439350154925 -3.378681102264494 -3.35061004712884 -3.316006856890527 -3.2835174670800034 -3.2537610961163175 -3.22616286338233 -3.194366718798201 -3.165176838693071 -3.138213563060108 -3.108321526482487 -3.0806230731292437 -3.0540091515294034 -3.0260397899751648 -2.998701113326364 -2.971985291987541 -2.9452943458666607 -2.9180643015295464 -2.8903845518218723 -2.86361305218577 -2.8362648676038384 -2.808812164512883 -2.781040833461293 -2.75299819463459 -2.72469318843225 -2.688060701639589 -2.659683406989727 -2.632605682073441 -2.6041297184007317 -2.577429566909113 -2.5503814664392532 -2.5234651305317777 -2.496515590508422 -2.4695572156178116 -2.442717161100853 -2.415802562461107 -2.388947408721988 -2.362251176202309 -2.33556611856836 -2.3069519077690575 -2.280019752814509 -2.25114571585445 -2.222602215034981 -2.1942918517876637 -2.1661966367336194 -2.1363482562037035 -2.1062614499862238 -2.076468309642545 -2.04697978889316 -2.0178051408747693 -1.9889520905565101 -1.9604271496719534 -1.9322356967809022 -1.904382111727573 -1.8768695645362807 -1.8497006625896386 -1.8229064571793776 -1.7963025728513435 -1.768149327906911 -1.7402764063764373 -1.7106993798948325 -1.6816162228286655 -1.653150759380554 -1.6251665538163975 -1.5976361210867194 -1.570534775623855 -1.5438747868997118 -1.5158432732457126 -1.488306253141798 -1.459467046031113 -1.4311832492805623 -1.403446839877938 -1.3762496869357959 -1.3493786406354855 -1.3205324559013762 -1.291973272844571 -1.2640576300363497 -1.2367580823207844 -1.2100419739408792 -1.1825184317986102 -1.1543329073266984 -1.1269102552601122 -1.1001630362455446 -1.0727929543674979 -1.044897321016112 -1.0179162948691705 -0.9845100434837863 -0.9499480390913309 -0.9166657253481827 -0.8846171908523733 -0.8537837707703282 -0.8241075866337088 -0.7955341243322044 -0.7680234698695103 -0.7413555018769391 -0.7118937404892559 -0.6795767668098571 -0.6488674985581321 -0.6197107793299845 -0.5919962982906622 -0.5649995710050038 -0.5345488519038223 -0.5053712754118771 -0.47801757179280757 -0.44987192265485054 -0.42133297984560064 -0.3944798578278659 -0.36653836942351403 -0.3388185797925272 -0.3117321350870775 -0.28474828358488996 -0.2572004072537036 -0.225933501090787 -0.1979134068408518 -0.17034024674326967 -0.14310483952131262 -0.11610987414046131 -0.11012170590587599 ]; 