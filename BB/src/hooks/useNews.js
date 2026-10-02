import useSWR from 'swr';
import { fetchNews, fetchTrendingNews, fetchBreakingNews, fetchCategories } from '../services/api';

// SWR fetchers (they just call the axios functions)
const fetcherNews = (key, category) => fetchNews(category);
const fetcherSimple = (key, fetcherFn) => fetcherFn();

export const useAllNews = (category = null) => {
  const { data, error, isLoading, mutate } = useSWR(
    category ? ['/news', category] : ['/news', null],
    ([url, cat]) => fetcherNews(url, cat),
    {
      revalidateOnFocus: false, // Prevents refetching just by switching tabs
      dedupingInterval: 60000, // 1 minute deduplication
    }
  );

  return { news: data, error, isLoading, mutate };
};

export const useTrendingNews = () => {
  const { data, error, isLoading } = useSWR(
    '/news/trending',
    () => fetchTrendingNews(),
    { revalidateOnFocus: false, dedupingInterval: 120000 }
  );
  return { trendingNews: data, error, isLoading };
};

export const useBreakingNews = () => {
  const { data, error, isLoading } = useSWR(
    '/breaking-news',
    () => fetchBreakingNews(),
    { refreshInterval: 60000, dedupingInterval: 30000 } // Poll every minute
  );
  return { breakingNews: data, error, isLoading };
};

export const useCategories = () => {
  const { data, error, isLoading } = useSWR(
    '/categories',
    () => fetchCategories(),
    { revalidateOnFocus: false, dedupingInterval: 300000 } // Cache for 5 mins
  );
  return { categories: data, error, isLoading };
};
