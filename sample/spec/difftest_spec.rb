require 'spec_helper'
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
        it '#mult2_diff_test' do
            xij = [
                    [
                      [13.2, 15.7, 11.9],
                      [16.1, 15.7, 15.1],
                      [9.1,  10.3,  8.2],
                    ],
                    [
                      [22.8, 25.7, 18.5],
                      [24.5, 21.2, 24.2],
                      [11.9, 14.3, 13.7],
                    ],
                    [
                      [21.8, 26.3, 32.1],
                      [26.9, 31.3, 28.3],
                      [15.1, 13.6, 16.2],
                    ],
                    [
                      [25.7, 28.8, 29.5],
                      [30.1, 33.8, 29.6],
                      [15.2, 17.3, 14.8],
                    ],
            ]
            res = [true, true]
            expect(
                paraTest2.mult2_diff_test(xij, a)
            ).to is_array(res)
        end
        it '#ancova_test' do
            yi = [
                [3, 5, 3],
                [3, 3, 8],
                [2, 2, 2],
                [3, 4, 2],
                [1, 2, 0],
           ]
           xi = [
              [35, 38, 39],
              [36, 39, 54],
              [40, 45, 39],
              [47, 52, 48],
              [64, 80, 70],
            ]
            expect(
               paraTest2.ancova_test(yi, xi, a)
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
        it '#mult2_diff_test' do
            xij = [
                [13.6, 15.6, 9.2],
                [22.3, 23.3, 13.3],
                [26.7, 28.8, 15.0],
                [28.0, 31.2, 15.8],
            ]
            expect(
                nonParaTest.mult2_diff_test(xij, a)
            ).to eq true
        end
    end
end

