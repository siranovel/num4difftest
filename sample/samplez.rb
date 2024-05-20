require 'num4difftest'
require 'num4hypothtst'

RSpec.describe Num4DiffTestLib do
    let!(:a) { 0.05 }
    describe Num4DiffTestLib::ParametrixTestLib do
        let!(:hypothTest2) { Num4HypothTestLib::TwoSideTestLib.new }
        let!(:paraTest2) { Num4DiffTestLib::ParametrixTestLib.new(hypothTest2) }

        it '#smple_diff_test' do
            xi1 = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
            xi2 = [180, 180, 235, 270, 240, 285, 164, 152]
            expect(
                paraTest2.smple_diff_test(xi1, xi2, a)
            ).to eq false
        end
        it '#mult_diff_test' do
            xij = [
                [12.2, 18.8, 18.2],
                [22.2, 20.5, 14.6],
                [20.8, 19.5, 26.3],
                [26.4, 32.5, 31.3],
                [24.5, 21.2, 22.4],
            ]
            expect(
                paraTest2.mult_diff_test(xij, a)
            ).to eq true
        end
    end
    describe Num4DiffTestLib::NonParametrixTestLib do
        let!(:hypothTest2) { Num4HypothTestLib::TwoSideTestLib.new }
        let!(:nonParaTest) { Num4DiffTestLib::NonParametrixTestLib.new(hypothTest2) }
        it '#smple_diff_test' do
            xi1 = [165, 130, 182, 178, 194, 206, 160, 122, 212, 165, 247, 195]
            xi2 = [180, 180, 235, 270, 240, 285, 164, 152]
            expect(
                nonParaTest.smple_diff_test(xi1, xi2, a)
            ).to eq false
        end
        it '#mult_diff_test' do
            xi = [
                [12.2, 18.8, 18.2],
                [22.2, 20.5, 14.6, 20.8, 19.5, 26.3],
                [26.4, 32.5, 31.3, 24.5, 21.2, 22.4],
            ]
            expect(
                nonParaTest.mult_diff_test(xi, a)
            ).to eq true
        end
    end
end

