function [X, out] = checkDiversity(X, opts)

[ninst,nfeats] = size(X);
if opts.flag
    disp('-> Checking for feature diversity.');
    out.pctage = zeros(1,nfeats);
    for i=1:nfeats
        if all(isnan(X(:,i))) || all(isinf(X(:,i)))
            out.pctage(i) = 0;
        else
            out.pctage(i) = length(unique(X(:,i)))./ninst;
        end
    end
    out.selvars = out.pctage>opts.threshold;
    if sum(out.selvars)<2
        error('Feature selection using diversity is too strict. Please increase the threshold value.')
    end
    X = X(:,out.selvars);
    disp(['-> Keeping ' num2str(size(X,2)) ' out of ' num2str(nfeats) ' features (diversity).']);
else
    out.pctage = ones(1,nfeats);
    out.selvars = true(1,nfeats);
end

end