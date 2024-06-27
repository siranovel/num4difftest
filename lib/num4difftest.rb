require 'num4tststatistic2'
require 'hypothTest3'
require 'num4anova'

# 母平均の差の検定
module Num4DiffTestLib
    # パラメトリック検定
    class ParametrixTestLib
        def initialize(hypothTest3)
            @hypothTest3 = hypothTest3
            @paraTest    = Num4TstStatistic2Lib::ParametrixTestLib.new(@hypothTest3)
            @oneWay      = Num4AnovaLib::OneWayLayoutLib.new
            @twoWay      = Num4AnovaLib::TwoWayLayoutLib.new
            @ancova      = Num4AnovaLib::Num4AncovaLib.new
        end
        # 2群の母平均の差の検定
        #
        # @overload smple_diff_test(xi1, xi2, a)
        #   @param [Array]  xi1 データ(double[])
        #   @param [Array]  xi2 データ(double[])
        #   @param  [double] a  有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   xi1 = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
        #   xi2 = [180, 180, 235, 270, 240, 285, 164, 152]
        #   hypothTest2 = Num4HypothTestLib::TwoSideTestLib.new
        #   paraTest2 = Num4DiffTestLib::ParametrixTestLib.new(hypothTest2)
        #   paraTest2.smple_diff_test(xi1, xi2, 0.05)
        #   => false
        def smple_diff_test(xi1, xi2, a)
            raise TypeError unless @hypothTest3.kind_of?(HypothTest3IF)

            if xi1.size == xi2.size then
                return @paraTest.diffPopulationMean(xi1, xi2, a)
            else
                return @paraTest.diffPopulationVarMean(xi1, xi2, a)
            end
        end
        # 3群以上の母平均の差の検定(1元配置)
        #
        # @overload mult_diff_test(xi1, a)
        #   @param  [Array]  xi1 データ(double[][])
        #   @param  [double] a  有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   xi = [
        #        [12.2, 18.8, 18.2],
        #        [22.2, 20.5, 14.6],
        #        [20.8, 19.5, 26.3],
        #        [26.4, 32.5, 31.3],
        #        [24.5, 21.2, 22.4],
        #   ]
        #   hypothTest2 = Num4HypothTestLib::TwoSideTestLib.new
        #   paraTest2 = Num4DiffTestLib::ParametrixTestLib.new(hypothTest2)
        #   paraTest2.mult_diff_test(xi, 0.05)
        #   => false
        def mult_diff_test(xi, a)
            raise TypeError unless @hypothTest3.kind_of?(HypothTest3IF)

            if true == isReplicate(xi) then
                return @oneWay.replicate_test(xi, a)
            else
                return @oneWay.oneway_anova(xi, a)
            end
        end
        # 3群以上の母平均の差の検定(2元配置)
        #
        # @overload mult2_diff_test(xij, a)
        #   @param  [Array]  xi1 データ(double[][][] or double[][])
        #   @param  [double] a  有意水準
        #   @return [Array] 検定結果(boolean[] true:棄却域内 false:棄却域外)
        # @example
        #   xij = [
        #            [
        #              [13.2, 15.7, 11.9],
        #              [16.1, 15.7, 15.1],
        #              [9.1,  10.3,  8.2],
        #            ],
        #            [
        #              [22.8, 25.7, 18.5],
        #              [24.5, 21.2, 24.2],
        #              [11.9, 14.3, 13.7],
        #            ],
        #            [
        #              [21.8, 26.3, 32.1],
        #              [26.9, 31.3, 28.3],
        #              [15.1, 13.6, 16.2],
        #            ],
        #            [
        #              [25.7, 28.8, 29.5],
        #              [30.1, 33.8, 29.6],
        #              [15.2, 17.3, 14.8],
        #            ],
        #   ]
        #   hypothTest2 = Num4HypothTestLib::TwoSideTestLib.new
        #   paraTest2 = Num4DiffTestLib::ParametrixTestLib.new(hypothTest2)
        #   paraTest2.mult2_diff_test(xij, 0.05)
        #   =>
        #     [true, true]
        def mult2_diff_test(xi1, a)
            raise TypeError unless @hypothTest3.kind_of?(HypothTest3IF)
      
            xij = xi1
            n = getDimNum(xi1, 0)
            if n == 3 then             # 繰り返しのあるデータ
                res = @twoWay.twoway_anova(xi1, a)
                if res[2] == true then
                    xij = @twoWay.create_oneway(xi1).to_a
                end
            end
            res2 = @twoWay.twoway2_anova(xij, a)
            return res2
        end
        # 共分散分析
        #
        # @overload ancova_test(yi, xi, a)
        #   @param [Array] yi データ(double[][])
        #   @param [Array] xi データ(double[][])
        #   @param  [double] a  有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   yi = [
        #       [3, 5, 3],
        #       [3, 3, 8],
        #       [2, 2, 2],
        #       [3, 4, 2],
        #       [1, 2, 0],
        #   ]
        #   xi = [
        #      [35, 38, 39],
        #      [36, 39, 54],
        #      [40, 45, 39],
        #      [47, 52, 48],
        #      [64, 80, 70],
        #    ]
        #   hypothTest2 = Num4HypothTestLib::TwoSideTestLib.new
        #   paraTest2 = Num4DiffTestLib::ParametrixTestLib.new(hypothTest2)
        #   paraTest2.ancova_test(yi, xi, 0.05)
        #   => true
        def ancova_test(yi, xi, a)
            # 回帰直線の平行性検定
            #  (false: 平行)
            if false !=  @ancova.parallel_test(yi, xi, a) then
                return mult_diff_test(xi, a)
            end
            # 回帰直線の有意性検定
            #  (false: β=0)
            if true != @ancova.significance_test(yi, xi, a) then
                return mult_diff_test(xi, a)
            end
            # 水準間の差の検定
            return @ancova.difference_test(yi, xi, a)
        end

        def getDimNum(xij, n)
            return n unless xij.kind_of?(Array)
            n += 1
            getDimNum(xij[0], n)
        end
        def isReplicate(xij)
          ret = true
          n = xij.size
          n0 = xij[0].size
          n.times do |i|
              if n0 != xij[i].size then
                  ret = false
              end
          end
          return ret
        end

        private :getDimNum
        private :isReplicate
    end
    # ノンパラメトリック検定
    class NonParametrixTestLib
        def initialize(hypothTest3)
            @hypothTest3 = hypothTest3
            @nonParaTest = Num4TstStatistic2Lib::NonParametrixTestLib.new(@hypothTest3)
            @oneWay      = Num4AnovaLib::OneWayLayoutLib.new
            @twoWay      = Num4AnovaLib::TwoWayLayoutLib.new
        end
        # 2群の母平均の差の検定
        #
        # @overload smple_diff_test(xi1, xi2, a)
        #   @param [Array]  xi1 データ(double[])
        #   @param [Array]  xi2 データ(double[])
        #   @param  [double] a  有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   xi1 = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
        #   xi2 = [180, 180, 235, 270, 240, 285, 164, 152]
        #   hypothTest2 = Num4HypothTestLib::TwoSideTestLib.new
        #   nonParaTest = Num4DiffTestLib::NonParametrixTestLib.new(hypothTest2)
        #   nonParaTest.smple_diff_test(xi1, xi2, 0.05)
        #   => false
        def smple_diff_test(xi1, xi2, a)
            raise TypeError unless @hypothTest3.kind_of?(HypothTest3IF)

            if xi1.size == xi2.size then
                return @nonParaTest.wilcoxon(xi1, xi2, a)
            else
                return @nonParaTest.utest(xi1, xi2, a)
            end
        end
        # 3群以上の母平均の差の検定(1元配置)
        #
        # @overload mult_diff_test(xi1, a)
        #   @param [Array]  xi1 データ(double[][])
        #   @param  [double] a  有意水準
        #   @return [boolean] 検定結果(true:棄却域内 false:棄却域外)
        # @example
        #   xi = [
        #        [12.2, 18.8, 18.2],
        #        [22.2, 20.5, 14.6, 20.8, 19.5, 26.3],
        #        [26.4, 32.5, 31.3, 24.5, 21.2, 22.4],
        #   ]
        #   hypothTest2 = Num4HypothTestLib::TwoSideTestLib.new
        #   nonParaTest = Num4DiffTestLib::NonParametrixTestLib.new(hypothTest2)
        #   nonParaTest.mult_diff_test(xi, 0.05)
        #   => false
        def mult_diff_test(xi1, a)
            raise TypeError unless @hypothTest3.kind_of?(HypothTest3IF)

            return @oneWay.kruskalwallis_test(xi1, a)
        end
        # 3群以上の母平均の差の検定(2元配置)
        #
        # @overload mult2_diff_test(xij, a)
        #   @param  [Array]  xi1 データ(double[][][] or double[][])
        #   @param  [double] a  有意水準
        #   @return [Array] 検定結果(boolean[] true:棄却域内 false:棄却域外)
        # @example
        #   xij = [
        #        [13.6, 15.6, 9.2],
        #        [22.3, 23.3, 13.3],
        #        [26.7, 28.8, 15.0],
        #        [28.0, 31.2, 15.8],
        #   ]
        #   hypothTest2 = Num4HypothTestLib::TwoSideTestLib.new
        #   nonParaTest = Num4DiffTestLib::NonParametrixTestLib.new(hypothTest2)
        #   nonParaTest.mult2_diff_test(xij, a)
        #   => true
        def mult2_diff_test(xij, a)
            raise TypeError unless @hypothTest3.kind_of?(HypothTest3IF)

            return @twoWay.friedman_test(xij, a)
        end        
    end
end

