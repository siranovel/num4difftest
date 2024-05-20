require 'num4tststatistic2'
require 'hypothTest3'
require 'num4anova'

module Num4DiffTestLib
    # パラメトリック検定
    class ParametrixTestLib
        def initialize(hypothTest3)
            @hypothTest3 = hypothTest3
            @paraTest    = Num4TstStatistic2Lib::ParametrixTestLib.new(@hypothTest3)
            @oneWay      = Num4AnovaLib::OneWayLayoutLib.new
            @twoWay      = Num4AnovaLib::TwoWayLayoutLib.new
        end
        def smple_diff_test(xi1, xi2, a)
            raise TypeError unless @hypothTest3.kind_of?(HypothTest3IF)

            if xi1.size == xi2.size then
                return @paraTest.diffPopulationMean(xi1, xi2, a)
            else
                return @paraTest.diffPopulationVarMean(xi1, xi2, a)
            end
        end
        def mult_diff_test(xi1, a)
            raise TypeError unless @hypothTest3.kind_of?(HypothTest3IF)

            return @oneWay.oneway_anova(xi1, a)
        end
    end
    # ノンパラメトリック検定
    class NonParametrixTestLib
        def initialize(hypothTest3)
            @hypothTest3 = hypothTest3
            @nonParaTest = Num4TstStatistic2Lib::NonParametrixTestLib.new(@hypothTest3)
            @oneWay      = Num4AnovaLib::OneWayLayoutLib.new
            @twoWay      = Num4AnovaLib::TwoWayLayoutLib.new
        end
        def smple_diff_test(xi1, xi2, a)
            raise TypeError unless @hypothTest3.kind_of?(HypothTest3IF)

            if xi1.size == xi2.size then
                return @nonParaTest.wilcoxon(xi1, xi2, a)
            else
                return @nonParaTest.utest(xi1, xi2, a)
            end
        end
        def mult_diff_test(xi1, a)
            raise TypeError unless @hypothTest3.kind_of?(HypothTest3IF)

            return @oneWay.kruskalwallis_test(xi1, a)
        end
    end
end

