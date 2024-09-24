class AecsitesController < ApplicationController


    #このディレクトリ内にある色の意味
    #緑色：db/migrate内に格納されているモデルの名前を指している
    #水色：変数。この変数はviewで反映したい時に共通言語として使う。例、@aaとつけたらhtmlでも@aaと定めてそこから投稿や編集機能に反映させる
    def index
    end
    def profile
    end
    def universitylife
    end
    def tchcourcelist
        @tchcourcelists=Aecsite.all #db/migrate/生年月日_~Aecsiteモデル内にあるカラムを@tchcourcelistに代入する時に使うコード
    end
    def commoncource
        @commoncources=Aecsite.all
    end
    def tlcource
        @tlcources=Aecsite.all
    end
    
    def commoncourcenew
        @commoncource=Aecsite.new
    end

    def tchcourcelistnew
        @tchcourcelist=Aecsite.new
    end

    def tlcourcenew
        @tlcource=Aecsite.new
    end
    
    
    
    def create
        @aecsite = Aecsite.new(aecsite_params)
    
        if @aecsite.save
          case params[:model]
          when "tlcource"
            redirect_to tlcource_path(@aecsite), notice: 'Tlcourceを投稿しました'
          when "tchcourcelist"
            redirect_to tchcourcelist_path(@aecsite), notice: 'Tchcourcelistを投稿しました'
          when "commoncource"
            redirect_to commoncource_path(@aecsite), notice: 'Commoncourceを投稿しました'
          else
            redirect_to root_path, alert: '不正なリクエストです'
          end
        else
          render "#{params[:model]}new"
        end
    end








    
    #共通教養科目の削除機能
    def destroy_commoncource
        commoncource = Aecsite.find_by(id: params[:id])
    
        if commoncource
          commoncource&.destroy #「&.」は存在しないデータベースによるエラーを防げる
          redirect_to commoncources_path, notice: "投稿が削除されました"
        else
          redirect_to commoncources_path, alert: "投稿が見つかりません"
        end
      end

    #工学科共通科目の削除機能
    def destroy_tchcourcelist
        tchcourcelist = Aecsite.find_by(id: params[:id])
    
        if tchcourcelist
          tchcourcelist&.destroy
          redirect_to tchcourcelists_path, notice: "投稿が削除されました"
        else
          redirect_to tchcourcelists_path, alert: "投稿が見つかりません"
        end
    end

    #電子情報工学科の削除機能
    def destroy_tlcource
        tlcource = Aecsite.find_by(id: params[:id])
    
        if tlcource
          tlcource&.destroy
          redirect_to tlcources_path, notice: "投稿が削除されました"
        else
          redirect_to tlcources_path, alert: "投稿が見つかりません"
        end
    end
    

    private

    def aecsite_params
        params.require(:aecsite).permit(:lecture, :professor, :grade, :reportage)
    end

    def commoncource_params
        params.require(:aecsite).permit(:lecture, :professor, :grade, :reportage)
    end

    def tchcourcelist_params
        params.require(:aecsite).permit(:lecture, :professor, :grade, :reportage)
    end

    def tlcource_params
        params.require(:aecsite).permit(:lecture, :professor, :grade, :reportage)
    end

    def destroy_aecsite(id, redirect_path)
        aecsite = Aecsite.find_by(id: id)
    
        if aecsite
          aecsite.destroy
          redirect_to redirect_path, notice: "投稿が削除されました"
        else
          redirect_to redirect_path, alert: "投稿が見つかりません"
        end
    end


end
