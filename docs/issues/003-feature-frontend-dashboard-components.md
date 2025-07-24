# 003-feature-frontend-dashboard-components / フロントエンドダッシュボードコンポーネント実装

## Overview / 概要
This issue focuses on implementing the frontend dashboard components using Nuxt.js, Chart.js, and TailwindCSS. The goal is to create a modern, responsive sales dashboard that visualizes data from the backend API with four different chart types.
この課題は、Nuxt.js、Chart.js、TailwindCSSを使ってフロントエンドダッシュボードコンポーネントを実装することに焦点を当てます。バックエンドAPIのデータを4種類の異なるチャートタイプで可視化する、モダンでレスポンシブな売上ダッシュボードの作成が目標です。

## Prerequisites / 前提条件
- [x] 001-feature-set-up-dev-env completed / 001-feature-set-up-dev-env が完了済み
- [x] 002-feature-database-and-api-setup completed / 002-feature-database-and-api-setup が完了済み
- [x] Backend API endpoints are accessible / バックエンドAPIエンドポイントにアクセス可能
- [x] Docker environment is working / Docker環境が動作している

## Scope / スコープ

### 1. Project Setup & Dependencies / 1. プロジェクトセットアップと依存関係

#### 1.1 Frontend Dependencies Installation / 1.1 フロントエンド依存関係インストール
- [ ] Install Chart.js and vue-chartjs for data visualization:
      データ可視化用のChart.jsとvue-chartjsをインストール：
```bash
npm install chart.js vue-chartjs
```

- [ ] Install additional Nuxt modules:
      追加のNuxtモジュールをインストール：
```bash
npm install @nuxtjs/axios @pinia/nuxt
npm install --save-dev @nuxtjs/tailwindcss
```

#### 1.2 Nuxt Configuration Update / 1.2 Nuxt設定更新
- [ ] Update `nuxt.config.ts` with required modules:
      必要なモジュールで`nuxt.config.ts`を更新：
```typescript
export default defineNuxtConfig({
  devtools: { enabled: true },
  modules: [
    '@nuxtjs/tailwindcss',
    '@pinia/nuxt'
  ],
  runtimeConfig: {
    public: {
      apiBase: 'http://localhost:3000/api/v1'
    }
  },
  css: ['~/assets/css/main.css']
})
```

### 2. Layout and UI Foundation / 2. レイアウトとUI基盤

#### 2.1 Main Layout Creation / 2.1 メインレイアウト作成
- [ ] Create `layouts/default.vue` with responsive design:
      レスポンシブデザインで`layouts/default.vue`を作成：
  - Header with navigation / ナビゲーション付きヘッダー
  - Responsive grid layout / レスポンシブグリッドレイアウト
  - TailwindCSS styling / TailwindCSSスタイリング

#### 2.2 Dashboard Main Page / 2.2 ダッシュボードメインページ
- [ ] Create `pages/index.vue` as dashboard home:
      ダッシュボードホームとして`pages/index.vue`を作成：
  - 4-chart grid layout / 4チャートグリッドレイアウト
  - Chart containers with loading states / ローディング状態付きチャートコンテナ
  - Error handling display / エラーハンドリング表示

### 3. Chart Components Implementation / 3. チャートコンポーネント実装

#### 3.1 Pie Chart Component / 3.1 円グラフコンポーネント
- [ ] Create `components/charts/PieChart.vue`:
      `components/charts/PieChart.vue`を作成：
  - Display category-wise sales distribution / カテゴリ別売上分布を表示
  - Use data from `/api/v1/sales_by_category` endpoint / `/api/v1/sales_by_category`エンドポイントのデータを使用
  - Implement responsive design / レスポンシブデザインを実装
  - Add interactive tooltips / インタラクティブツールチップを追加

#### 3.2 Bar Chart Component / 3.2 棒グラフコンポーネント
- [ ] Create `components/charts/BarChart.vue`:
      `components/charts/BarChart.vue`を作成：
  - Display monthly sales data / 月次売上データを表示
  - Use data from `/api/v1/monthly_sales` endpoint / `/api/v1/monthly_sales`エンドポイントのデータを使用
  - Implement horizontal scrolling for mobile / モバイル用水平スクロールを実装
  - Add value labels on bars / バーに値ラベルを追加

#### 3.3 Line Chart Component / 3.3 折れ線グラフコンポーネント
- [ ] Create `components/charts/LineChart.vue`:
      `components/charts/LineChart.vue`を作成：
  - Display sales trend over time / 時系列売上トレンドを表示
  - Use data from `/api/v1/sales_trend` endpoint / `/api/v1/sales_trend`エンドポイントのデータを使用
  - Implement trend analysis features / トレンド分析機能を実装
  - Add zoom and pan capabilities / ズームとパン機能を追加

#### 3.4 Radar Chart Component / 3.4 レーダーチャートコンポーネント
- [ ] Create `components/charts/RadarChart.vue`:
      `components/charts/RadarChart.vue`を作成：
  - Display product comparison metrics / 商品比較指標を表示
  - Use data from `/api/v1/product_comparison` endpoint / `/api/v1/product_comparison`エンドポイントのデータを使用
  - Allow product selection for comparison / 比較用商品選択を許可
  - Implement multi-product overlay / 複数商品オーバーレイを実装

### 4. Data Management / 4. データ管理

#### 4.1 API Service Layer / 4.1 APIサービス層
- [ ] Create `composables/useApi.ts` for API communication:
      API通信用の`composables/useApi.ts`を作成：
```typescript
export const useApi = () => {
  const config = useRuntimeConfig()
  
  const fetchSalesByCategory = () => $fetch(`${config.public.apiBase}/sales_by_category`)
  const fetchMonthlySales = () => $fetch(`${config.public.apiBase}/monthly_sales`)
  const fetchSalesTrend = () => $fetch(`${config.public.apiBase}/sales_trend`)
  const fetchProductComparison = () => $fetch(`${config.public.apiBase}/product_comparison`)
  
  return {
    fetchSalesByCategory,
    fetchMonthlySales,
    fetchSalesTrend,
    fetchProductComparison
  }
}
```

#### 4.2 State Management / 4.2 状態管理
- [ ] Create Pinia stores for dashboard data:
      ダッシュボードデータ用のPiniaストアを作成：
  - `stores/dashboard.ts` for chart data management / チャートデータ管理用
  - Loading and error state handling / ローディングとエラー状態ハンドリング
  - Data caching and refresh functionality / データキャッシュと更新機能

### 5. Styling and Responsive Design / 5. スタイリングとレスポンシブデザイン

#### 5.1 TailwindCSS Configuration / 5.1 TailwindCSS設定
- [ ] Configure custom color palette:
      カスタムカラーパレットを設定：
```javascript
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      colors: {
        primary: {
          50: '#eff6ff',
          500: '#3b82f6',
          600: '#2563eb',
          700: '#1d4ed8',
        },
        dashboard: {
          bg: '#f8fafc',
          card: '#ffffff',
          border: '#e2e8f0',
        }
      }
    }
  }
}
```

#### 5.2 Responsive Layout Implementation / 5.2 レスポンシブレイアウト実装
- [ ] Implement mobile-first responsive design:
      モバイルファーストレスポンシブデザインを実装：
  - Mobile: Single column layout / モバイル：単一カラムレイアウト
  - Tablet: 2x2 grid layout / タブレット：2x2グリッドレイアウト  
  - Desktop: 2x2 optimized grid / デスクトップ：最適化された2x2グリッド

#### 5.3 Chart Styling / 5.3 チャートスタイリング
- [ ] Create consistent chart theme:
      一貫したチャートテーマを作成：
  - Color scheme matching overall design / 全体デザインに合致したカラースキーム
  - Typography consistency / タイポグラフィの一貫性
  - Animation and transition effects / アニメーションとトランジション効果

### 6. User Experience Enhancements / 6. ユーザーエクスペリエンス向上

#### 6.1 Loading States / 6.1 ローディング状態
- [ ] Implement skeleton loading for charts:
      チャート用スケルトンローディングを実装：
  - Chart-specific loading animations / チャート固有のローディングアニメーション
  - Progressive data loading / プログレッシブデータローディング

#### 6.2 Error Handling / 6.2 エラーハンドリング
- [ ] Create comprehensive error handling:
      包括的なエラーハンドリングを作成：
  - API connection errors / API接続エラー
  - Data parsing errors / データ解析エラー
  - User-friendly error messages / ユーザーフレンドリーなエラーメッセージ
  - Retry functionality / 再試行機能

#### 6.3 Interactive Features / 6.3 インタラクティブ機能
- [ ] Add chart interaction capabilities:
      チャートインタラクション機能を追加：
  - Click events for data drilling / データドリリング用クリックイベント
  - Hover effects and tooltips / ホバー効果とツールチップ
  - Data filtering and sorting / データフィルタリングとソート

### 7. Performance Optimization / 7. パフォーマンス最適化

#### 7.1 Code Splitting / 7.1 コード分割
- [ ] Implement lazy loading for chart components:
      チャートコンポーネントの遅延ローディングを実装：
```typescript
const PieChart = defineAsyncComponent(() => import('~/components/charts/PieChart.vue'))
```

#### 7.2 Data Optimization / 7.2 データ最適化
- [ ] Implement efficient data fetching:
      効率的なデータフェッチングを実装：
  - Parallel API calls / 並列API呼び出し
  - Data transformation optimization / データ変換最適化
  - Memory-efficient chart rendering / メモリ効率的なチャートレンダリング

## Technical Specifications / 技術仕様

### Chart Configuration / チャート設定

#### Pie Chart (Category Sales) / 円グラフ（カテゴリ売上）
```typescript
const pieOptions = {
  responsive: true,
  plugins: {
    legend: {
      position: 'bottom'
    },
    tooltip: {
      callbacks: {
        label: (context) => `${context.label}: ¥${context.parsed.toLocaleString()}`
      }
    }
  }
}
```

#### Bar Chart (Monthly Sales) / 棒グラフ（月次売上）
```typescript
const barOptions = {
  responsive: true,
  scales: {
    y: {
      beginAtZero: true,
      ticks: {
        callback: (value) => `¥${value.toLocaleString()}`
      }
    }
  }
}
```

### API Integration Pattern / API統合パターン
```typescript
// composables/useChartData.ts
export const useChartData = () => {
  const { $fetch } = useNuxtApp()
  const config = useRuntimeConfig()
  
  const fetchChartData = async (endpoint: string) => {
    try {
      const response = await $fetch(`${config.public.apiBase}/${endpoint}`)
      return response.data
    } catch (error) {
      throw createError({
        statusCode: 500,
        statusMessage: `Failed to fetch ${endpoint} data`
      })
    }
  }
  
  return { fetchChartData }
}
```

## Testing Requirements / テスト要件

### 7.1 Component Testing / 7.1 コンポーネントテスト
- [ ] Unit tests for chart components:
      チャートコンポーネントのユニットテスト：
  - Props validation / プロップス検証
  - Data rendering accuracy / データレンダリング精度
  - Event handling / イベントハンドリング

### 7.2 Integration Testing / 7.2 統合テスト
- [ ] API integration tests:
      API統合テスト：
  - Data fetching functionality / データフェッチング機能
  - Error handling scenarios / エラーハンドリングシナリオ
  - State management integration / 状態管理統合

### 7.3 Visual Testing / 7.3 ビジュアルテスト
- [ ] Cross-browser compatibility testing:
      クロスブラウザ互換性テスト：
  - Chrome, Firefox, Safari / Chrome、Firefox、Safari
  - Mobile browsers / モバイルブラウザ
  - Responsive design validation / レスポンシブデザイン検証

## Definition of Done / 完了条件
- [ ] All four chart components are implemented and functional
      4つのチャートコンポーネント全てが実装され機能している
- [ ] Dashboard displays real data from backend API endpoints
      ダッシュボードがバックエンドAPIエンドポイントからの実データを表示している
- [ ] Responsive design works on mobile, tablet, and desktop
      レスポンシブデザインがモバイル、タブレット、デスクトップで動作している
- [ ] Error handling is implemented for all API calls
      全API呼び出しでエラーハンドリングが実装されている
- [ ] Loading states are displayed during data fetching
      データフェッチング中にローディング状態が表示されている
- [ ] Charts are interactive with tooltips and hover effects
      チャートがツールチップとホバー効果でインタラクティブになっている
- [ ] Performance is optimized with code splitting and lazy loading
      コード分割と遅延ローディングでパフォーマンスが最適化されている
- [ ] Visual design is consistent and professional
      ビジュアルデザインが一貫性があり専門的である
- [ ] All components are properly typed with TypeScript
      全コンポーネントがTypeScriptで適切に型付けされている
- [ ] Cross-browser compatibility is verified
      クロスブラウザ互換性が確認されている

## Next Steps / 次のステップ
After completing this issue, the following enhancements can be implemented:
この課題完了後、以下の機能拡張が実装可能：
- Advanced filtering and date range selection / 高度なフィルタリングと日付範囲選択
- Data export functionality / データエクスポート機能
- Real-time data updates / リアルタイムデータ更新
- User preferences and dashboard customization / ユーザー設定とダッシュボードカスタマイズ

## Dependencies / 依存関係
This issue depends on:
この課題は以下に依存：
- 001-feature-set-up-dev-env (completed) / 001-feature-set-up-dev-env（完了済み）
- 002-feature-database-and-api-setup (completed) / 002-feature-database-and-api-setup（完了済み）

This issue enables:
この課題により可能になる：
- Advanced dashboard features implementation / 高度なダッシュボード機能実装
- User authentication and personalization / ユーザー認証とパーソナライゼーション
- Data export and reporting features / データエクスポートとレポート機能