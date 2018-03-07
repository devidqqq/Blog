package com.blog.util;


public class Sort{

	/**
	 * 1.直接插入排序
	 * 基本思想：在要排序的一组数中，假设前面的（n-1）n>2个数以排好顺序，
	 * 现在要把第n个数插到前面的有序数中，使得这n个数也是排好顺序的依次循环，
	 * 直到全部排好顺序
	 * @param arr
	 * @return int[]
	 */
	public static int[] insertSort(int[] arr){
		int temp = 0;
		for (int i = 1; i<arr.length ; i++ ) {
			temp = arr[i];
			int j=i-1;
			for (;j>=0 && temp<arr[j] ; j--) {
				arr[j+1] = arr[j];
			}
			arr[j+1] = temp;
		}
		return arr;
	}

	/**
	 * 希尔排序
	 * 基本思想：先将要排序的一组数按照某个增量d（n/2,n为要排序数的个数）分成若干组
	 * 每组中记录的下标相差d.对每组中全部元素进行直接插入排序
	 * 然后再用一个较小的增量（d/2）对它进行分组，在每组中再进行直接插入排序。
	 * 当增量减到1时，进行直接插入排序后，排序完成。
	 * @param arr
	 * @return int[]
	 */
	public static int[] shellSort(int[] arr) {
		double d1 = arr.length;
		int temp = 0;
		while(true) {
			d1 = Math.ceil(d1/2);
			int d = (int) d1;
			for(int i = 0; i<d; i++) {
				for (int j = 0; j < arr.length; j+=d) {
					int k = j-d;
					temp = arr[j];
					for (;k>=0 && temp<arr[k] ; k--) {
						arr[k+d] = arr[k];
					}
					arr[k+d] = temp;
				}
				
			}
			if(d==1) {
				break;
			}
		}
		return arr;
	}
	
	/**
	 * 冒泡排序：每当两相邻的数比较后发现它们的排序与排序要求相反时，就将它们互换
	 * @param arr
	 * @return int[]
	 */
	public static int[] bubbleSort(int[] arr) {
		int temp = 0;
		for (int i = 0; i < arr.length-1; i++) {
			for (int j = 0; j < arr.length-1-i; j++) {
				if(arr[j]>arr[j+1]){
					temp = arr[j];
					arr[j] = arr[j+1];
					arr[j+1] = temp;
				}
			}
		}
		return arr;
	}
	
	/**
	 * 选择排序
	 * 基本思想：在一组要排序的数中，先选出一个最小的数与第一个交换位置，
	 * 再选出第二个与第二个交换位置，依次循环，直到全部排好顺序
	 * @param arr
	 * @return int[]
	 */
	public static int[] selectSort(int[] arr) {
		int position=0;
		for(int i = 0; i<arr.length; i++){
			int j = i+1;
			position = i;
			int temp = arr[i];
			for( ; j < arr.length; j++){
				if(arr[j] < temp){
					temp = arr[j];
					position = j;
				}
			}
			arr[position] = arr[i];
			arr[i] = temp;
		}
		return arr;
	}
	
	public static void main(String[] args) {
		
		int[] a = {2,3,1,4,5,7};
		int[] result = insertSort(a);
		for (int i : result) {
			System.out.print(i+",");
		}
		System.out.println();
		int[] result2 = shellSort(a);
		for (int i : result2) {
			System.out.print(i+",");
		}
		
		System.out.println();
		int[] result3 = bubbleSort(a);
		for (int i : result3) {
			System.out.print(i+",");
		}
		
		System.out.println();
		int[] result4 = selectSort(a);
		for (int i : result4) {
			System.out.print(i+",");
		}
	}
 }



